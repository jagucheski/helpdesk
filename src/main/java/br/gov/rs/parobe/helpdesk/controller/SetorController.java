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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import br.gov.rs.parobe.helpdesk.dao.SetorDAO;
import br.gov.rs.parobe.helpdesk.jsonResponse.SetorJsonResponse;
import br.gov.rs.parobe.helpdesk.model.Setor;

@Controller
public class SetorController {

	@Autowired
	private SetorDAO setorDAO;

	/**
	 *  Acesso ao gerenciamento de setor
	 * 
	 *  Permissão de acesso:  SUP
	 **/					 
	@RequestMapping(value ="/setor" , method = RequestMethod.GET)
	public ModelAndView setor() {
		List<Setor> setores = setorDAO.getSetores();
		ModelAndView modelAndView = new ModelAndView("setor/setor");
		modelAndView.addObject("setores", setores);
		return modelAndView;
	}
	
	@RequestMapping(value="/setor/pesquisarSetor" , method = RequestMethod.POST)
	public ModelAndView pesquisarSetor(@RequestParam(value="nomeFind", required=false) String nome, 
								  @RequestParam(value="descricaoFind", required=false) String descricao) {
		List<Setor> setores = setorDAO.findBySetor(nome, descricao);
		ModelAndView modelAndView = new ModelAndView("setor/setor");
		modelAndView.addObject("setores", setores);
		return modelAndView;
	}
	
	/**
	 * Adicionar novo setor/adicionarSetor 
	 * 
	 *  Permissão de acesso:  SUP
	 **/
	@Transactional
	@PostMapping(value="/setor/adicionarSetor", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public SetorJsonResponse adicionarSetor(@ModelAttribute @Valid Setor setor, BindingResult result) {

		SetorJsonResponse response = new SetorJsonResponse();
		
		if (result.hasErrors()) {
	         Map<String, String> errors = result.getFieldErrors().stream()
	         .collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));	         
	         response.setValidated(false);
	         response.setErrorMessages(errors);
		} else if(setorDAO.existSetorByNome(setor.getNome())){
			Map<String, String> errors = new HashMap<String, String>();
			errors.put("nome", "Setor já cadastrado com este nome!");
            response.setValidated(false);
	        response.setErrorMessages(errors);			
		} else {	
			setorDAO.gravar(setor);
			response.setValidated(true);
		    response.setMessage("Setor cadastrado com sucesso!");
		}				
		return response;
	}
	
	/**
	 * Excluir setor através do mapping /excluirSetor 
	 * 
	 *  Permissão de acesso:  SUP
	 **/
	@Transactional
	@PostMapping(value="/setor/excluirSetor", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public SetorJsonResponse excluirSetor(@ModelAttribute Setor setorExcluir) {
		SetorJsonResponse response = new SetorJsonResponse();
		Map<String, String> errors = new HashMap<String, String>();
		try {
			Setor setor = setorDAO.getByNomeId(setorExcluir);

			if (setor.getChamados().size() > 0 || setor.getUsuarios().size() > 0) {
				errors.put("registros", "Ops... Este Setor não pode ser excluido, pois possui registros vinculados.");
				response.setValidated(false);
				response.setErrorMessages(errors);
			}else {
				setorDAO.deletar(setor);
				response.setValidated(true);
				response.setMessage("Setor excluído com sucesso!");
			}
		} catch (Exception e) {
			errors.put("errorSetor", "Ops... Ocorreu um erro inesperado.  " + e.getMessage().toString());
			response.setValidated(false);
			response.setErrorMessages(errors);
		}
		return response;
	}
	
	/**
	 * Editar dados do setor através do mapping /editarSetor 
	 * 
	 *  Permissão de acesso:  SUP
	 **/
	@Transactional
	@PostMapping(value="/setor/editarSetor", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public SetorJsonResponse editarSetor(@ModelAttribute @Valid Setor setorAlt, BindingResult result) {
		
		SetorJsonResponse response = new SetorJsonResponse();
	
		if (result.hasErrors()) {
			Map<String, String> errors = result.getFieldErrors().stream()
					.collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));	         
			response.setValidated(false);
			response.setErrorMessages(errors);
		}else {	
			Setor setor = setorDAO.getOne(setorAlt);
			setor.atualizaDados(setorAlt);
			setorDAO.gravar(setor);
			response.setValidated(true);
			response.setMessage("Dados atualizados com sucesso!");			
		}	
		return response;
	}	
	
	
}
