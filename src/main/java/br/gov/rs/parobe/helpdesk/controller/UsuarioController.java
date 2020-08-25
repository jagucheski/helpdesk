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
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.gov.rs.parobe.helpdesk.dao.UsuarioDAO;
import br.gov.rs.parobe.helpdesk.model.Usuario;
import br.gov.rs.parobe.helpdesk.model.UsuarioJsonResponse;

@Controller
@RequestMapping("/usuario")
public class UsuarioController {

	@Autowired
	UsuarioDAO usuarioDAO;

	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView usuario() {
		List<Usuario> usuarios = usuarioDAO.getUsuarios();
		ModelAndView modelAndView = new ModelAndView("usuario");
		modelAndView.addObject("usuarios", usuarios);
		return modelAndView;
	}

	@Transactional
	@RequestMapping("/deletar")
	public ModelAndView deletar(String email) {
		Usuario usuario = usuarioDAO.loadUserByUsername(email);
		usuarioDAO.deletar(usuario);
		return new ModelAndView("redirect:/usuario");
	}

	@Transactional
	@PostMapping(value="/adicionar", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public UsuarioJsonResponse adicionar(Model model,
										@ModelAttribute @Valid Usuario usuario, 
										BindingResult result,
										RedirectAttributes redirectAttributes) {

		UsuarioJsonResponse response = new UsuarioJsonResponse();
		
		//Get error message
		if (result.hasErrors()) {
	         Map<String, String> errors = result.getFieldErrors().stream()
	         .collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));	         
	         response.setValidated(false);
	         response.setErrorMessages(errors);
		} else if (!usuarioDAO.existUserName(usuario.getEmail())) {	
			usuarioDAO.gravar(usuario);
			response.setValidated(true);
		    response.setUsuario(usuario);
		    response.setMessage("Usuário cadastrado com sucesso!");
		}else {
			 response.setValidated(false);
			 Map<String, String> errors = new HashMap<String, String>();
			 errors.put("email", "Email já cadastrado!");
			 response.setUsuario(usuario);
			 response.setErrorMessages(errors);
		}
		return response;
	}
		
	@RequestMapping(value="/pesquisar" , method = RequestMethod.POST)
	public ModelAndView pesquisar(@RequestParam(value="nomeFind", required=false) String nome, 
								@RequestParam(value="emailFind", required=false) String email, 
								@RequestParam(value="perfilFind", required=false) String perfil, Model model) {
		List<Usuario> usuarios = usuarioDAO.findByUsuario(nome, email, perfil);
		model.addAttribute("usuarios", usuarios);
		return new ModelAndView("usuario");
	}
}
