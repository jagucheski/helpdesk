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

import br.gov.rs.parobe.helpdesk.dao.RoleDAO;
import br.gov.rs.parobe.helpdesk.dao.UsuarioDAO;
import br.gov.rs.parobe.helpdesk.model.Role;
import br.gov.rs.parobe.helpdesk.model.Usuario;
import br.gov.rs.parobe.helpdesk.model.UsuarioJsonResponse;

@Controller
public class UsuarioController {

	@Autowired
	UsuarioDAO usuarioDAO;

	@Autowired
	RoleDAO roleDAO;

	/**
	 *  Acesso ao gerenciamento de usuários
	 * 
	 *  Permissão de acesso:  ADMIN
	 **/
	@RequestMapping(value ="/usuario" , method = RequestMethod.GET)
	public ModelAndView usuario() {
		List<Usuario> usuarios = usuarioDAO.getUsuarios();
		ModelAndView modelAndView = new ModelAndView("usuarios/usuario");
		modelAndView.addObject("usuarios", usuarios);
		return modelAndView;
	}

	/**
	 *  Acesso a tela de atualização de dados pelo usuário
	 * 
	 *  Permissão de acesso: USER, ADMIN
	 **/
	@RequestMapping(value="/usuarioAtualizarDados" , method = RequestMethod.GET)
	public ModelAndView usuarioAtualizarDados() {
		ModelAndView modelAndView = new ModelAndView("usuarios/usuarioAtualizarDados");
		Usuario usuario =  (Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		modelAndView.addObject("usuario", (Usuario) usuarioDAO.loadUserByUsername(usuario.getEmail()));
		return modelAndView;
	}
	
	/**
	 *  Acesso a tela de atualização de senha
	 * 
	 *  Permissão de acesso: USER  
	 **/
	@RequestMapping(value="/atualizarSenhaUsuario" , method = RequestMethod.GET)
	public ModelAndView atualizarSenhaUsuario() {
		ModelAndView modelAndView = new ModelAndView("usuarios/usuarioAtualizarSenha");
		Usuario usuario =  (Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		modelAndView.addObject("usuario", (Usuario) usuarioDAO.loadUserByUsername(usuario.getEmail()));
		return modelAndView;
	}
	
	/**
	 *  Acesso a tela de atualização de perfil do usuário
	 * 
	 *  Permissão de acesso: ADMIN
	 **/
	@RequestMapping(value="/usuario/usuarioEditarPerfil/{email}" , method = RequestMethod.GET)
	public ModelAndView usuarioEditarPerfil(@PathVariable("email") String email) {
		ModelAndView modelAndView = new ModelAndView("usuarios/usuarioEditarPerfil");
		Usuario usuario = (Usuario) usuarioDAO.getByEmail(email);
		usuario.preparaPerfilList();
		modelAndView.addObject("usuario", usuario);
		modelAndView.addObject("roleList", roleDAO.getLabels());
		return modelAndView;
	}
	
	/**
	 * Atualiza nova senha do usuário alterada pelo próprio usuário quando o ADMIN seta como alteração obrigatória no cadastro do usuário.
	 * Acessada através dp mapping /usuarioAlteraSenha
	 **/
	@Transactional
	@PostMapping(value="/atualizarSenha")
	@ResponseBody
	public UsuarioJsonResponse atualizarSenha(Usuario usuarioAlt) {
		
		UsuarioJsonResponse response = new UsuarioJsonResponse();
		
		if (!usuarioAlt.validaSenha()) {
			Map<String, String> errors = new HashMap<String, String>();
			errors.put("senha", "A senha deve conter no mínimo 6 caracteres");
	         response.setValidated(false);
	         response.setErrorMessages(errors);
		} else {	
			Usuario usuarioBase = usuarioDAO.loadUserByUsername(usuarioAlt.getEmail());
			usuarioAlt.passwordEncoder();
			usuarioBase.setSenha(usuarioAlt.getSenha());
			usuarioBase.setAlterarSenha(false);
			usuarioDAO.gravar(usuarioBase);
			response.setValidated(true);
		    response.setUsuario(usuarioBase);
		    response.setMessage("Senha alterada com sucesso!  Efetue login novamente.");
		}
		return response;
	}	
	
	/**
	 * Atualiza os dados do usuário quando o próprio usuário altera seus dados através do mapping /usuarioAtualizarDados 
	 * 
	 *  Permissão de acesso:  USER
	 **/
	@Transactional
	@PostMapping(value="/atualizarDadosUsuario", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public UsuarioJsonResponse atualizarDadosUsuario(@ModelAttribute @Valid Usuario usuarioAlt, BindingResult result) {
		
		UsuarioJsonResponse response = new UsuarioJsonResponse();
		
		if (result.hasErrors()) {
			Map<String, String> errors = result.getFieldErrors().stream()
					.collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));	         
			response.setValidated(false);
			response.setErrorMessages(errors);
		} else {	
			usuarioAlt.passwordEncoder();
			Usuario usuario = usuarioDAO.loadUserByUsername(usuarioAlt.getEmail());
			usuario.setTelefone(usuarioAlt.getTelefone());
			usuario.setRamal(usuarioAlt.getRamal());
			usuario.setSenha(usuarioAlt.getSenha());
			usuarioDAO.gravar(usuario);
			response.setValidated(true);
			response.setUsuario(usuario);
			response.setMessage("Dados alterados com sucesso!");
		}
		return response;
	}	
		
	/**
	 * Adicionar novo usuário /adicionar 
	 * 
	 *  Permissão de acesso:  ADMIN
	 **/
	@Transactional
	@PostMapping(value="/usuario/adicionar", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public UsuarioJsonResponse adicionar(@ModelAttribute @Valid Usuario usuario, BindingResult result) {

		UsuarioJsonResponse response = new UsuarioJsonResponse();
		
		if (result.hasErrors()) {
	         Map<String, String> errors = result.getFieldErrors().stream()
	         .collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));	         
	         response.setValidated(false);
	         response.setErrorMessages(errors);
		} else if(usuarioDAO.existUserName(usuario.getEmail())){
			Map<String, String> errors = new HashMap<String, String>();
			errors.put("email", "Email já cadastrado!");
            response.setValidated(false);
	        response.setErrorMessages(errors);			
		} else {	
			usuario.passwordEncoder();
			usuario.getRoles().add(roleDAO.getByNome("ROLE_USER"));
			usuarioDAO.gravar(usuario);
			response.setValidated(true);
		    response.setMessage("Usuário cadastrado com sucesso!");
		}		
		
		return response;
	}
	
	/**
	 * Atualiza os dados do usuário através do mapping /atualizarUsuario 
	 * 
	 *  Permissão de acesso:  ADMIN
	 **/
	@Transactional
	@PostMapping(value="/usuario/atualizarUsuario", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public UsuarioJsonResponse atualizarUsuario(@ModelAttribute @Valid Usuario usuarioAlt, BindingResult result) {
		
		UsuarioJsonResponse response = new UsuarioJsonResponse();
	
		if (result.hasErrors()) {
			Map<String, String> errors = result.getFieldErrors().stream()
					.collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));	         
			response.setValidated(false);
			response.setErrorMessages(errors);
		} else if(!validaEmailAtualizarUsuario(usuarioAlt.getEmail(), usuarioAlt.getEmailBase())){ 
			 response.setValidated(false);
			 Map<String, String> errors = new HashMap<String, String>();
			 errors.put("email", "Email já cadastrado!");
			 response.setUsuario(usuarioAlt);
			 response.setErrorMessages(errors);
		}else {	
			
			Usuario usuario = usuarioDAO.loadUserByUsername(usuarioAlt.getEmailBase());
			usuario.atualizaDados(usuarioAlt);
			usuarioDAO.gravar(usuario);
			response.setValidated(true);
			response.setUsuario(usuario);
			response.setMessage("Dados atualizados com sucesso!");
		}	
		return response;
	}	
	
	/**
	 * Atualiza a senha do usuário através do mapping /alterarSenhaUsuario 
	 **/
	@Transactional
	@PostMapping(value="/usuario/alterarSenhaUsuario", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public UsuarioJsonResponse alterarSenhaUsuario(@ModelAttribute Usuario usuarioAlt) {
		UsuarioJsonResponse response = new UsuarioJsonResponse();

		if (!usuarioAlt.validaSenha()) {
			Map<String, String> errors = new HashMap<String, String>();
			errors.put("senha", "A senha deve conter no mínimo 6 caracteres");
			response.setValidated(false);
			response.setErrorMessages(errors);
		} else {	
			Usuario usuario = usuarioDAO.loadUserByUsername(usuarioAlt.getEmail());
			usuario.setSenha(usuarioAlt.getSenha());
			usuario.setAlterarSenha(usuarioAlt.isAlterarSenha());			
			usuario.passwordEncoder();
			usuarioDAO.gravar(usuario);
			response.setValidated(true);
			response.setMessage("Senha alterada com sucesso!");
		}	
		return response;
	}
	
	
	
	//TODO
	/**
	 * Atualiza a perfil do usuário através do mapping /editarPerfilUsuario 
	 **/
	@Transactional
	@PostMapping(value="/usuario/editarPerfilUsuario", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public UsuarioJsonResponse editarPerfilUsuario(@ModelAttribute Usuario usuario) {
		UsuarioJsonResponse response = new UsuarioJsonResponse();
		Usuario usuarioBase = usuarioDAO.getByEmail(usuario.getEmail());
		usuarioBase.setRoles(new ArrayList<Role>());
			
		//Adiciona padrão ROLE_USER  
		if(usuario.getPerfis().isEmpty() || !usuario.contemPerfil("Usuário"))
			usuarioBase.getRoles().add(roleDAO.getByNome("ROLE_USER"));
		
		//Adiciona os perfis selecionados a lista roles do usuario
		for(String perfil : usuario.getPerfis()){
			usuarioBase.getRoles().add(roleDAO.getByLabel(perfil));
		}
		
		try {
			usuarioDAO.gravar(usuarioBase);
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
	
	/**
	 * Excluir usuario através do mapping /excluir 
	 * 
	 *  Permissão de acesso:  ADMIN
	 **/
	@Transactional
	@PostMapping(value="/usuario/excluir", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public UsuarioJsonResponse excluir(@ModelAttribute Usuario usuarioExcluir) {
		UsuarioJsonResponse response = new UsuarioJsonResponse();
		try {
			Usuario usuarioLog =  (Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			if(usuarioLog.getEmail().equals(usuarioExcluir.getEmail())) {
				response.setValidated(false);
				response.setMessage("Você não pode excluir sua conta de usuário.");
			}else {
				Usuario usuario = usuarioDAO.loadUserByUsername(usuarioExcluir.getEmail());
				usuarioDAO.deletar(usuario);
				response.setValidated(true);
				response.setMessage("Usuário excluído com sucesso!");
			}
		} catch (Exception e) {
			response.setValidated(false);
			response.setMessage("Ops... Ocorreu um erro inesperado.  " + e.getMessage().toString());
		}
		return response;
	}
		
	@RequestMapping(value="/usuario/pesquisar" , method = RequestMethod.POST)
	public ModelAndView pesquisar(@RequestParam(value="nomeFind", required=false) String nome, 
								  @RequestParam(value="emailFind", required=false) String email, 
								  @RequestParam(value="perfilFind", required=false) String perfil) {
		List<Usuario> usuarios = usuarioDAO.findByUsuario(nome, email, perfil);
		ModelAndView modelAndView = new ModelAndView("usuarios/usuario");
		modelAndView.addObject("usuarios", usuarios);
		return modelAndView;
	}
	
	private boolean validaEmailAtualizarUsuario(String emailUsuarioAlt, String emailUsuario) {
		boolean response = false;
		if (usuarioDAO.existUserName(emailUsuarioAlt) && emailUsuarioAlt.equals(emailUsuario)) 
			response = true;
		
		if (!usuarioDAO.existUserName(emailUsuarioAlt) && !emailUsuarioAlt.equals(emailUsuario)) 
			response = true;
		
		if(usuarioDAO.existUserName(emailUsuarioAlt) && !emailUsuarioAlt.equals(emailUsuario))
			response = false;
		
		return response;
	}
}
