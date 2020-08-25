package br.gov.rs.parobe.helpdesk.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.context.SecurityContextHolder;
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

import br.gov.rs.parobe.helpdesk.dao.OperadorDAO;
import br.gov.rs.parobe.helpdesk.dao.RoleDAO;
import br.gov.rs.parobe.helpdesk.jsonResponse.UsuarioJsonResponse;
import br.gov.rs.parobe.helpdesk.model.Role;
import br.gov.rs.parobe.helpdesk.model.Usuario;

@Controller
public class OperadorController {

	@Autowired
	private OperadorDAO operadorDAO;

	@Autowired
	private RoleDAO roleDAO;

	/**
	 *  Acesso ao gerenciamento de operador
	 * 
	 *  Permissão de acesso:  ADMIN
	 **/
	@RequestMapping(value ="/operador" , method = RequestMethod.GET)
	public ModelAndView operador() {
		List<Usuario> operadores = operadorDAO.getOperadores();
		ModelAndView modelAndView = new ModelAndView("operador/operador");
		modelAndView.addObject("operadores", operadores);
		return modelAndView;
	}
	
	/**
	 *  Acesso a tela de atualização de perfil do operador
	 * 
	 *  Permissão de acesso: ADMIN
	 **/
	@RequestMapping(value="/operador/operadorEditarPerfil/{email}" , method = RequestMethod.GET)
	public ModelAndView operadorEditarPerfil(@PathVariable("email") String email) {
		ModelAndView modelAndView = new ModelAndView("operador/operadorEditarPerfil");
		Usuario operador = (Usuario) operadorDAO.getByEmail(email);
		operador.preparaPerfilList();
		modelAndView.addObject("operador", operador);
		modelAndView.addObject("roleList", roleDAO.getLabels());
		return modelAndView;
	}
	

	@RequestMapping(value="/operador/pesquisar" , method = RequestMethod.POST)
	public ModelAndView pesquisar(@RequestParam(value="nomeFind", required=false) String nome, 
								  @RequestParam(value="emailFind", required=false) String email, 
								  @RequestParam(value="perfilFind", required=false) String perfil) {
		List<Usuario> operadores = operadorDAO.findByOperador(nome, email, perfil);
		ModelAndView modelAndView = new ModelAndView("operador/operador");
		modelAndView.addObject("operadores", operadores);
		return modelAndView;
	}
	
	/**
	 * Adicionar novo operador /adicionar 
	 * 
	 *  Permissão de acesso:  ADMIN
	 **/
	@Transactional
	@PostMapping(value="/operador/adicionar", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public UsuarioJsonResponse adicionar(@ModelAttribute @Valid Usuario usuario, BindingResult result) {

		UsuarioJsonResponse response = new UsuarioJsonResponse();
		
		if (result.hasErrors()) {
	         Map<String, String> errors = result.getFieldErrors().stream()
	         .collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));	         
	         response.setValidated(false);
	         response.setErrorMessages(errors);
		} else if(operadorDAO.existUserName(usuario.getEmail())){
			Map<String, String> errors = new HashMap<String, String>();
			errors.put("email", "Email já cadastrado!");
            response.setValidated(false);
	        response.setErrorMessages(errors);			
		} else {	
			usuario.passwordEncoder();
			usuario.getRoles().add(roleDAO.getByNome("ROLE_USER"));
			usuario.getRoles().add(roleDAO.getByNome("ROLE_SUP"));
			operadorDAO.gravar(usuario);
			response.setValidated(true);
		    response.setMessage("Operador cadastrado com sucesso!");
		}		
		
		return response;
	}
	
	/**
	 * Excluir operador através do mapping /excluir 
	 * 
	 *  Permissão de acesso:  ADMIN
	 **/
	@Transactional
	@PostMapping(value="/operador/excluir", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public UsuarioJsonResponse excluir(@ModelAttribute Usuario usuarioExcluir) {
		UsuarioJsonResponse response = new UsuarioJsonResponse();
		try {
			Usuario usuarioLog =  (Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			if(usuarioLog.getEmail().equals(usuarioExcluir.getEmail())) {
				response.setValidated(false);
				response.setMessage("Você não pode excluir sua conta de operador.");
			}else {
				Usuario usuario = operadorDAO.loadUserByUsername(usuarioExcluir.getEmail());
				operadorDAO.deletar(usuario);
				response.setValidated(true);
				response.setMessage("Operador excluído com sucesso!");
			}
		} catch (Exception e) {
			response.setValidated(false);
			response.setMessage("Ops... Ocorreu um erro inesperado.  " + e.getMessage().toString());
		}
		return response;
	}
	
	/**
	 * Atualiza a senha do operador através do mapping /alterarSenhaOperador 
	 **/
	@Transactional
	@PostMapping(value="/operador/alterarSenhaOperador", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public UsuarioJsonResponse alterarSenhaOperador(@ModelAttribute Usuario usuarioAlt) {
		UsuarioJsonResponse response = new UsuarioJsonResponse();

		if (!usuarioAlt.validaSenha()) {
			Map<String, String> errors = new HashMap<String, String>();
			errors.put("senha", "A senha deve conter no mínimo 6 caracteres");
			response.setValidated(false);
			response.setErrorMessages(errors);
		} else {	
			Usuario usuario = operadorDAO.loadUserByUsername(usuarioAlt.getEmail());
			usuario.setSenha(usuarioAlt.getSenha());
			usuario.setAlterarSenha(usuarioAlt.isAlterarSenha());			
			usuario.passwordEncoder();
			operadorDAO.gravar(usuario);
			response.setValidated(true);
			response.setMessage("Senha alterada com sucesso!");
		}	
		return response;
	}
	
	
	/**
	 * Editar dados do operador através do mapping /editarOperador 
	 * 
	 *  Permissão de acesso:  ADMIN
	 **/
	@Transactional
	@PostMapping(value="/operador/editarOperador", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public UsuarioJsonResponse editarOperador(@ModelAttribute @Valid Usuario usuarioAlt, BindingResult result) {
		
		UsuarioJsonResponse response = new UsuarioJsonResponse();
	
		if (result.hasErrors()) {
			Map<String, String> errors = result.getFieldErrors().stream()
					.collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));	         
			response.setValidated(false);
			response.setErrorMessages(errors);
		}else {	
			Usuario usuario = operadorDAO.loadUserByUsername(usuarioAlt.getEmail());
			usuario.atualizaDados(usuarioAlt);
			operadorDAO.gravar(usuario);
			response.setValidated(true);
			response.setMessage("Dados atualizados com sucesso!");
		}	
		return response;
	}	
	
	/**
	 * Atualiza a perfil do operador através do mapping /editarPerfilOperador
	 **/
	@Transactional
	@PostMapping(value="/operador/editarPerfilOperador", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public UsuarioJsonResponse editarPerfilOperador(@ModelAttribute Usuario usuario) {
		UsuarioJsonResponse response = new UsuarioJsonResponse();
		Usuario usuarioBase = operadorDAO.getByEmail(usuario.getEmail());
		usuarioBase.setRoles(new ArrayList<Role>());
			
		//Adiciona padrão ROLE_USER  
		if(usuario.getPerfis().isEmpty() || !usuario.contemPerfil("Usuário"))
			usuarioBase.getRoles().add(roleDAO.getByNome("ROLE_USER"));
		
		//Adiciona padrão ROLE_USER  
		if(usuario.getPerfis().isEmpty() || !usuario.contemPerfil("Suporte"))
			usuarioBase.getRoles().add(roleDAO.getByNome("ROLE_SUP"));
		
		//Adiciona os perfis selecionados a lista roles do usuario
		for(String perfil : usuario.getPerfis()){
			usuarioBase.getRoles().add(roleDAO.getByLabel(perfil));
		}
		
		try {
			operadorDAO.gravar(usuarioBase);
			response.setValidated(true);
			response.setMessage("Perfil atualizado com sucesso");
		} catch (Exception e) {
			Map<String, String> errors = new HashMap<String, String>();
			errors.put("perfil", "Ops... Ocorreu um erro. Tente novamente. ");
			errors.put("erro", e.getMessage());
			response.setValidated(false);
			response.setErrorMessages(errors);			
		}	
		return response;
	}	
	
	
}
