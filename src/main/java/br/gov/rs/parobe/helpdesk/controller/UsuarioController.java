package br.gov.rs.parobe.helpdesk.controller;

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import br.gov.rs.parobe.helpdesk.dao.UsuarioDAO;
import br.gov.rs.parobe.helpdesk.jsonResponse.UsuarioJsonResponse;
import br.gov.rs.parobe.helpdesk.model.Usuario;

@Controller
public class UsuarioController {

	@Autowired
	private UsuarioDAO usuarioDAO;

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
		    response.setMessage("Senha alterada com sucesso!  Você será redirecionado ...");
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
			Usuario usuario = usuarioDAO.loadUserByUsername(usuarioAlt.getEmail());
			usuario.atualizaDados(usuarioAlt);
			usuarioDAO.gravar(usuario);
			response.setValidated(true);
			response.setMessage("Dados alterados com sucesso!");
		}
		return response;
	}	
	
}
