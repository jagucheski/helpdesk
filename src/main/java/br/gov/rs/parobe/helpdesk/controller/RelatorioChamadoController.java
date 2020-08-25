package br.gov.rs.parobe.helpdesk.controller;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import br.gov.rs.parobe.helpdesk.dao.ChamadoDtoDAO;
import br.gov.rs.parobe.helpdesk.dao.SetorDAO;
import br.gov.rs.parobe.helpdesk.dto.ChamadoEstatisticoDto;
import br.gov.rs.parobe.helpdesk.model.Setor;
import br.gov.rs.parobe.helpdesk.model.StatusChamado;

@Controller
public class RelatorioChamadoController {

	@Autowired
	private ChamadoDtoDAO chamadoDtoDAO;
	
	@Autowired
	private SetorDAO setorDAO;
	
	@RequestMapping(value = "/relatorioChamadoEstatistico", method = RequestMethod.GET)
	public ModelAndView relatorioChamadoEstatistico() {
		ModelAndView modelAndView  = preparaModelAndView();
		return modelAndView;
	}
	
	@RequestMapping(value="/relatorioChamadoEstatistico/pesquisar" , method = RequestMethod.POST)
	public ModelAndView pesquisar(@ModelAttribute(name = "chamadoDtoFind") ChamadoEstatisticoDto chamadoDtoFind) {
		ModelAndView modelAndView  = preparaModelAndView();
		List<ChamadoEstatisticoDto> relatorioChamados = chamadoDtoDAO.findChamadosEstatisticoByYear(chamadoDtoFind);
		modelAndView.addObject("relatorioChamados", relatorioChamados);
		return modelAndView;
	}
	
	private ModelAndView preparaModelAndView() {
		ModelAndView modelAndView = new ModelAndView("relatorio/relatorioChamadoEstatistico","chamadoDtoFind", new ChamadoEstatisticoDto());
		List<Setor> setores = setorDAO.getSetores();
		modelAndView.addObject("setores", setores);
		modelAndView.addObject("statusList", Arrays.asList(StatusChamado.values()));
		return modelAndView;
	}
	
}
