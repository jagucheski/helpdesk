package br.gov.rs.parobe.helpdesk.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import br.gov.rs.parobe.helpdesk.dao.RoleDAO;
import br.gov.rs.parobe.helpdesk.dao.SetorDAO;
import br.gov.rs.parobe.helpdesk.dao.SolicitanteDAO;
import br.gov.rs.parobe.helpdesk.jsonResponse.UsuarioJsonResponse;
import br.gov.rs.parobe.helpdesk.model.Usuario;

@Controller
public class SolicitanteController {

	@Autowired
	private SolicitanteDAO solicitanteDAO;

	@Autowired
	private RoleDAO roleDAO;

	@Autowired
	private SetorDAO setorDAO;

	/**
	 *  Acesso ao gerenciamento de solicitantes
	 * 
	 *  Permissão de acesso:  ADMIN
	 **/					 
	@RequestMapping(value ="/solicitante" , method = RequestMethod.GET)
	public ModelAndView solicitante() {
		List<Usuario> solicitantes = solicitanteDAO.getSolicitantes();
		ModelAndView modelAndView = new ModelAndView("solicitante/solicitante");
		modelAndView.addObject("solicitantes", solicitantes);
		return modelAndView;
	}

	@RequestMapping(value="/solicitante/pesquisar" , method = RequestMethod.POST)
	public ModelAndView pesquisar(@RequestParam(value="nomeFind", required=false) String nome, 
								  @RequestParam(value="emailFind", required=false) String email) {
		List<Usuario> solicitantes = solicitanteDAO.findBySolicitante(nome, email);
		ModelAndView modelAndView = new ModelAndView("solicitante/solicitante");
		modelAndView.addObject("solicitantes", solicitantes);
		return modelAndView;
	}
	
	/**
	 *  Acesso a tela de vinculo de setor
	 * 
	 *  Permissão de acesso: SUP
	 **/
	@RequestMapping(value="/solicitante/solicitanteVincularSetor/{email}" , method = RequestMethod.GET)
	public ModelAndView solicitanteVincularSetor(@PathVariable("email") String email) {
		ModelAndView modelAndView = new ModelAndView("solicitante/solicitanteVincularSetor");
		Usuario solicitante = solicitanteDAO.getByEmail(email);
		
		if(solicitante.getSetor()!=null)
			solicitante.setSetorAtivo(solicitante.getSetor().getId());
		
		modelAndView.addObject("solicitante", solicitante);
		modelAndView.addObject("setores", setorDAO.getSetores());
		return modelAndView;
	}
	
	/**
	 * Adicionar novo solicitante /adicionar 
	 * 
	 *  Permissão de acesso:  ADMIN
	 **/
	@Transactional
	@PostMapping(value="/solicitante/adicionar", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public UsuarioJsonResponse adicionar(@ModelAttribute @Valid Usuario usuario, BindingResult result) {

		UsuarioJsonResponse response = new UsuarioJsonResponse();
		
		if (result.hasErrors()) {
	         Map<String, String> errors = result.getFieldErrors().stream()
	         .collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));	         
	         response.setValidated(false);
	         response.setErrorMessages(errors);
		} else if(solicitanteDAO.existUserName(usuario.getEmail())){
			Map<String, String> errors = new HashMap<String, String>();
			errors.put("email", "Email já cadastrado!");
            response.setValidated(false);
	        response.setErrorMessages(errors);			
		} else {	
			usuario.setNome(usuario.getNome().replace("-", ""));
			usuario.passwordEncoder();
			usuario.getRoles().add(roleDAO.getByNome("ROLE_USER"));
			solicitanteDAO.gravar(usuario);
			response.setValidated(true);
		    response.setMessage("Solicitante cadastrado com sucesso!");
		}				
		return response;
	}
	
	/**
	 * Excluir solicitante através do mapping /excluir 
	 * 
	 *  Permissão de acesso:  ADMIN
	 **/
	@Transactional
	@PostMapping(value="/solicitante/excluir", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public UsuarioJsonResponse excluir(@ModelAttribute Usuario usuarioExcluir) {
		UsuarioJsonResponse response = new UsuarioJsonResponse();
		Map<String, String> errors = new HashMap<String, String>();
		try {
			Usuario usuario = solicitanteDAO.loadUserByUsername(usuarioExcluir.getEmail());
			if(usuario.getChamados().size() > 0) {
		        errors.put("registros",  "Ops... Este Solicitante não pode ser excluido, pois possui chamados vinculados.");
	            response.setValidated(false);
		        response.setErrorMessages(errors);				
			}else {
				solicitanteDAO.deletar(usuario);
				response.setValidated(true);
				response.setMessage("Solicitante excluído com sucesso!");
			}
		} catch (Exception e) {
			 errors.put("categoria", "Ops... Ocorreu um erro inesperado.  " + e.getMessage().toString());
	         response.setValidated(false);
		     response.setErrorMessages(errors);
		}
		return response;
	}
	
	/**
	 * Atualiza a senha do solicitante através do mapping /alterarSenhaSolicitante 
	 **/
	@Transactional
	@PostMapping(value="/solicitante/alterarSenhaSolicitante", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public UsuarioJsonResponse alterarSenhaSolicitante
	(@ModelAttribute Usuario usuarioAlt) {
		UsuarioJsonResponse response = new UsuarioJsonResponse();

		if (!usuarioAlt.validaSenha()) {
			Map<String, String> errors = new HashMap<String, String>();
			errors.put("senha", "A senha deve conter no mínimo 6 caracteres");
			response.setValidated(false);
			response.setErrorMessages(errors);
		} else {	
			Usuario usuario = solicitanteDAO.loadUserByUsername(usuarioAlt.getEmail());
			usuario.setSenha(usuarioAlt.getSenha());
			usuario.setAlterarSenha(usuarioAlt.isAlterarSenha());			
			usuario.passwordEncoder();
			solicitanteDAO.gravar(usuario);
			response.setValidated(true);
			response.setMessage("Senha alterada com sucesso!");
		}	
		return response;
	}
	
	
	/**
	 * Editar dados do solicitante através do mapping /editarSolicitante 
	 * 
	 *  Permissão de acesso:  ADMIN
	 **/
	@Transactional
	@PostMapping(value="/solicitante/editarSolicitante", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public UsuarioJsonResponse editarSolicitante(@ModelAttribute @Valid Usuario usuarioAlt, BindingResult result) {
		
		UsuarioJsonResponse response = new UsuarioJsonResponse();
	
		if (result.hasErrors()) {
			Map<String, String> errors = result.getFieldErrors().stream()
					.collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));	         
			response.setValidated(false);
			response.setErrorMessages(errors);
		}else {	
			Usuario usuario = solicitanteDAO.loadUserByUsername(usuarioAlt.getEmail());
			usuario.atualizaDados(usuarioAlt);
			solicitanteDAO.gravar(usuario);
			response.setValidated(true);
			response.setMessage("Dados atualizados com sucesso!");
		}	
		return response;
	}	
	
	/**
	 * Ativar solicitante/vincularSetorSolicitante
	 **/
	@Transactional
	@PostMapping(value="/solicitante/vincularSetorSolicitante", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public UsuarioJsonResponse vincularSetorSolicitante(@ModelAttribute Usuario usario) {
		UsuarioJsonResponse response = new UsuarioJsonResponse();
		Usuario usuarioBase = solicitanteDAO.loadUserByUsername(usario.getEmail());
		try {
			usuarioBase.setSetor(setorDAO.getById(usario.getSetorAtivo()));
			solicitanteDAO.gravar(usuarioBase);
			response.setValidated(true);
			response.setMessage("Setor vinculado com sucesso");
		} catch (Exception e) {
			Map<String, String> errors = new HashMap<String, String>();
			errors.put("setor", "Ops... Ocorreu um erro. Tente novamente. ");
			errors.put("erro", e.getMessage());
			response.setValidated(false);
			response.setErrorMessages(errors);			
		}	
		return response;
	}	
	
}
