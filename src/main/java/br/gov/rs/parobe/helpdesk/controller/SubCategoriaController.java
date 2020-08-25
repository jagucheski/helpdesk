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

import br.gov.rs.parobe.helpdesk.dao.SubCategoriaDAO;
import br.gov.rs.parobe.helpdesk.jsonResponse.SubCategoriaJsonResponse;
import br.gov.rs.parobe.helpdesk.model.SubCategoria;

@Controller
public class SubCategoriaController {

	@Autowired
	private SubCategoriaDAO subCategoriaDAO;
	
	/**
	 *  Acesso ao gerenciamento de subCategorias
	 * 
	 *  Permissão de acesso:  SUP
	 **/	
	@RequestMapping(value = "/subCategoria", method = RequestMethod.GET)
	public ModelAndView subCategoria() {
		List<SubCategoria> subCategorias = subCategoriaDAO.getSubCategorias();
		ModelAndView modelAndView = new ModelAndView("subCategoria/subCategoria");
		modelAndView.addObject("subCategorias", subCategorias);
		return modelAndView;
	}
	
	@RequestMapping(value="/subCategoria/pesquisarSubCategoria" , method = RequestMethod.POST)
	public ModelAndView pesquisarSubCategoria(@RequestParam(value="nomeFind", required=false) String nome) {
		List<SubCategoria> subCategorias = subCategoriaDAO.findBySubCategoria(nome);
		ModelAndView modelAndView = new ModelAndView("subCategoria/subCategoria");
		modelAndView.addObject("subCategorias", subCategorias);
		return modelAndView;
	}
	
	/**
	 * Adicionar nova subCategoria/adicionarSubCategoria 
	 * 
	 *  Permissão de acesso:  SUP
	 **/
	@Transactional
	@PostMapping(value="/subCategoria/adicionarSubCategoria", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public SubCategoriaJsonResponse adicionarSubCategoria(@ModelAttribute @Valid SubCategoria subCategoria, BindingResult result) {

		SubCategoriaJsonResponse response = new SubCategoriaJsonResponse();
		
		if (result.hasErrors()) {
	         Map<String, String> errors = result.getFieldErrors().stream()
	         .collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));	         
	         response.setValidated(false);
	         response.setErrorMessages(errors);
		} else if(subCategoriaDAO.existSubCategoriaByNome(subCategoria.getNome())){
			Map<String, String> errors = new HashMap<String, String>();
			errors.put("nome", "Sub-Categoria já cadastrada com este nome!");
            response.setValidated(false);
	        response.setErrorMessages(errors);			
		} else {	
			subCategoriaDAO.gravar(subCategoria);
			response.setValidated(true);
		    response.setMessage("Sub-Categoria cadastrada com sucesso!");
		}				
		return response;
	}
	
	/**
	 * Excluir subCategoria através do mapping /excluirSubCategoria 
	 * 
	 *  Permissão de acesso:  SUP
	 **/
	@Transactional
	@PostMapping(value="/subCategoria/excluirSubCategoria", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public SubCategoriaJsonResponse excluirSubCategoria(@ModelAttribute SubCategoria subCategoriaExcluir) {
		SubCategoriaJsonResponse response = new SubCategoriaJsonResponse();
		try {
			//TODO validar se o subCategoria esta ativo e vinculada a algum chamado
			SubCategoria subCategoria = subCategoriaDAO.getOne(subCategoriaExcluir);
			if (!subCategoria.getCategorias().isEmpty()){
		        Map<String, String> errors = new HashMap<String, String>();
		        errors.put("categoria", "Sub-Categoria não pode ser excluída, pois possui Categoria vinculada.");
	            response.setValidated(false);
		        response.setErrorMessages(errors);	
			}else {
				subCategoriaDAO.deletar(subCategoria);
				response.setValidated(true);
				response.setMessage("Sub-Categoria excluída com sucesso!");
			}
		} catch (Exception e) {
			response.setValidated(false);
			response.setMessage("Ops... Ocorreu um erro inesperado.  " + e.getMessage().toString());
		}
		return response;
	}
	
	/**
	 * Editar dados da subCategoria através do mapping /editarSubCategoria
	 *  Permissão de acesso:  SUP
	 **/
	@Transactional
	@PostMapping(value="/subCategoria/editarSubCategoria", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public SubCategoriaJsonResponse editarSubCategoria(@ModelAttribute @Valid SubCategoria subCategoriaAlt, BindingResult result) {
		
		SubCategoriaJsonResponse response = new SubCategoriaJsonResponse();
	
		if (result.hasErrors()) {
			Map<String, String> errors = result.getFieldErrors().stream()
					.collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));	         
			response.setValidated(false);
			response.setErrorMessages(errors);
		}else {	
			SubCategoria subCategoria = subCategoriaDAO.getOne(subCategoriaAlt);
			subCategoria.atualizaDados(subCategoriaAlt);
			subCategoriaDAO.gravar(subCategoria);
			response.setValidated(true);
			response.setMessage("Dados atualizados com sucesso!");			
		}	
		return response;
	}	
		
	
}
