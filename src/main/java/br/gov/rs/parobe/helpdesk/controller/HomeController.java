package br.gov.rs.parobe.helpdesk.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import br.gov.rs.parobe.helpdesk.dao.UsuarioDAO;
import br.gov.rs.parobe.helpdesk.model.Usuario;

@Controller
public class HomeController {

	@Autowired
	private UsuarioDAO usuarioDAO;
	
	@RequestMapping("/home")
	public ModelAndView home() {
		Usuario usuarioTemp = (Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Usuario usuario = usuarioDAO.loadUserByUsername(usuarioTemp.getEmail());
		if(usuario.isAlterarSenha()) {
			return new ModelAndView("redirect:/atualizarSenhaUsuario");
		}
		return new ModelAndView("home");
	}
}
