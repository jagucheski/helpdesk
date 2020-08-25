package br.gov.rs.parobe.helpdesk.controller;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import br.gov.rs.parobe.helpdesk.dao.ChamadoDtoDAO;
import br.gov.rs.parobe.helpdesk.dao.UsuarioDAO;
import br.gov.rs.parobe.helpdesk.dto.ChamadoMesStatusDto;
import br.gov.rs.parobe.helpdesk.jsonResponse.ChartBarChamadoJsonResponse;
import br.gov.rs.parobe.helpdesk.model.Usuario;

@Controller
public class HomeController {

	@Autowired
	private UsuarioDAO usuarioDAO;

	@Autowired
	private ChamadoDtoDAO chamadoDtoDAO;

	@RequestMapping("/home")
	public ModelAndView home() {
		Usuario usuarioTemp = (Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Usuario usuario = usuarioDAO.loadUserByUsername(usuarioTemp.getEmail());
		if (usuario.isAlterarSenha()) {
			return new ModelAndView("redirect:/atualizarSenhaUsuario");
		}
		return new ModelAndView("home");
	}

	/**
	 * Permissão de acesso: USER
	 **/
	@Transactional
	@PostMapping(value = "/home/garregaChart", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public ChartBarChamadoJsonResponse garregaChart(@ModelAttribute Usuario usuarioTemp) {
		ChartBarChamadoJsonResponse response = new ChartBarChamadoJsonResponse();
		String anoCorrente = String.valueOf(LocalDateTime.now().getYear());
		String mesCorrente = String.valueOf(LocalDateTime.now().getMonthValue());
		
		response.setData(carregaDataChart(usuarioTemp, anoCorrente,mesCorrente));

		response.setTitulo("Chamados");
		response.setSubTitulo(mesCorrente+"/" + anoCorrente);
		response.setValidated(true);
		response.setMessage("Tudo certo");
		
		return response;

	}
	
	private String carregaDataChart(Usuario usuarioTemp, String anoCorrente, String mesCorrente) {
		Usuario usuario = usuarioDAO.loadUserByUsername(usuarioTemp.getEmail());
		List<ChamadoMesStatusDto> chamados = chamadoDtoDAO.getChamadosCharBarDto(usuario, anoCorrente, mesCorrente);

		long qtdeAguardandoAtendimento = 0;
		long qtdeAguardandoRetornoSolicitante = 0;
		long qtdeAguardandoTerceiros = 0;
		long qtdeAguardandoConcluido = 0;
		long qtdeAguardandoEmAtendimento = 0;

		for (ChamadoMesStatusDto chaMesStatus : chamados) {
			if (chaMesStatus.getStatus().equals("Aguardando atendimento")) {
				qtdeAguardandoAtendimento = chaMesStatus.getQtde();
			}
			if (chaMesStatus.getStatus().equals("Aguardando retorno do solicitante")) {
				qtdeAguardandoRetornoSolicitante = chaMesStatus.getQtde();
			}
			if (chaMesStatus.getStatus().equals("Aguardando terceiros")) {
				qtdeAguardandoTerceiros = chaMesStatus.getQtde();
			}
			if (chaMesStatus.getStatus().equals("Concluído")) {
				qtdeAguardandoConcluido = chaMesStatus.getQtde();
			}
			if (chaMesStatus.getStatus().equals("Em atendimento")) {
				qtdeAguardandoEmAtendimento = chaMesStatus.getQtde();
			}
		}

		String dataTableChart = "[['Mês', 'Aguardando atendimento', 'Aguardando retorno do solicitante', 'Aguardando terceiros', 'Concluído', 'Em atendimento'], ['"
				+ mesCorrente + "/" + anoCorrente + "'," + qtdeAguardandoAtendimento + "," + qtdeAguardandoRetornoSolicitante + ","
 					   + qtdeAguardandoTerceiros + "," + qtdeAguardandoConcluido + "," + qtdeAguardandoEmAtendimento
					   + "]]";

		return dataTableChart;
	}

}
