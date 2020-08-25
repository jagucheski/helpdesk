package br.gov.rs.parobe.helpdesk.controller;

import java.util.ArrayList;
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

import br.gov.rs.parobe.helpdesk.dao.CategoriaDAO;
import br.gov.rs.parobe.helpdesk.dao.SubCategoriaDAO;
import br.gov.rs.parobe.helpdesk.jsonResponse.CategoriaJsonResponse;
import br.gov.rs.parobe.helpdesk.model.Categoria;
import br.gov.rs.parobe.helpdesk.model.SubCategoria;

@Controller
public class CategoriaController {

	@Autowired
	private CategoriaDAO categoriaDAO;
	
	@Autowired
	private SubCategoriaDAO subCategoriaDAO;
	
	/**
	 *  Acesso ao gerenciamento de categorias
	 * 
	 *  Permissão de acesso:  SUP
	 **/	
	@RequestMapping(value = "/categoria", method = RequestMethod.GET)
	public ModelAndView categoria() {
		List<Categoria> categorias = categoriaDAO.getCategorias();
		ModelAndView modelAndView = new ModelAndView("categoria/categoria");
		modelAndView.addObject("categorias", categorias);
		return modelAndView;
	}
	
	@RequestMapping(value="/categoria/pesquisarCategoria" , method = RequestMethod.POST)
	public ModelAndView pesquisarCategoria(@RequestParam(value="nomeFind", required=false) String nome) {
		List<Categoria> categorias = categoriaDAO.findByCategoria(nome);
		ModelAndView modelAndView = new ModelAndView("categoria/categoria");
		modelAndView.addObject("categorias", categorias);
		return modelAndView;
	}
	
	/**
	 *  Acesso a tela de vinculo de subcategoria
	 * 
	 *  Permissão de acesso: SUP
	 **/
	@RequestMapping(value="/categoria/categoriaVincularSubCategoria/{id}" , method = RequestMethod.GET)
	public ModelAndView categoriaVincularSubCategoria(@PathVariable("id") int id) {
		ModelAndView modelAndView = new ModelAndView("categoria/categoriaVincularSubCategoria");
		Categoria categoria = (Categoria) categoriaDAO.getById(id);
		categoria.preparaSubCategoriaList();
		modelAndView.addObject("categoria", categoria);
		modelAndView.addObject("subCategorias", subCategoriaDAO.getSubCategorias());
		return modelAndView;
	}
	
	/**
	 * Adicionar nova categoria/categoria 
	 * 
	 *  Permissão de acesso:  SUP
	 **/
	@Transactional
	@PostMapping(value="/categoria/adicionarCategoria", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public CategoriaJsonResponse adicionarCategoria(@ModelAttribute @Valid Categoria categoria, BindingResult result) {

		CategoriaJsonResponse response = new CategoriaJsonResponse();
		
		if (result.hasErrors()) {
	         Map<String, String> errors = result.getFieldErrors().stream()
	         .collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));	         
	         response.setValidated(false);
	         response.setErrorMessages(errors);
		} else if(categoriaDAO.existCategoriaByNome(categoria.getNome())){
			Map<String, String> errors = new HashMap<String, String>();
			errors.put("nome", "Categoria já cadastrada com este nome!");
            response.setValidated(false);
	        response.setErrorMessages(errors);			
		} else {	
			categoriaDAO.gravar(categoria);
			response.setValidated(true);
		    response.setMessage("Categoria cadastrada com sucesso!");
		}				
		return response;
	}
	
	/**
	 * Excluir categoria através do mapping /excluirCategoria 
	 * 
	 *  Permissão de acesso:  SUP
	 **/
	@Transactional
	@PostMapping(value="/categoria/excluirCategoria", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public CategoriaJsonResponse excluirCategoria(@ModelAttribute Categoria categoriaExcluir) {
		CategoriaJsonResponse response = new CategoriaJsonResponse();
		try {
			//TODO validar se o categoria esta ativo e vinculado a algum chamado
			Categoria categoria = categoriaDAO.getOne(categoriaExcluir);
			categoriaDAO.deletar(categoria);
			response.setValidated(true);
			response.setMessage("Categoria excluída com sucesso!");
		} catch (Exception e) {
			response.setValidated(false);
			response.setMessage("Ops... Ocorreu um erro inesperado.  " + e.getMessage().toString());
		}
		return response;
	}
	
	/**
	 * Editar dados da categoria através do mapping /editarCategoria
	 *  Permissão de acesso:  SUP
	 **/
	@Transactional
	@PostMapping(value="/categoria/editarCategoria", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public CategoriaJsonResponse editarCategoria(@ModelAttribute @Valid Categoria categoriaAlt, BindingResult result) {
		
		CategoriaJsonResponse response = new CategoriaJsonResponse();
	
		if (result.hasErrors()) {
			Map<String, String> errors = result.getFieldErrors().stream()
					.collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));	         
			response.setValidated(false);
			response.setErrorMessages(errors);
		}else {	
			Categoria categoria = categoriaDAO.getOne(categoriaAlt);
			categoria.atualizaDados(categoriaAlt);
			categoriaDAO.gravar(categoria);
			response.setValidated(true);
			response.setMessage("Dados atualizados com sucesso!");			
		}	
		return response;
	}	
	
	/**
	 * Ativar subcategoria /ativarSubCategoria
	 **/
	@Transactional
	@PostMapping(value="/categoria/vincularSubCategoria", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public CategoriaJsonResponse vincularSubCategoria(@ModelAttribute Categoria categoria) {
		CategoriaJsonResponse response = new CategoriaJsonResponse();
		Categoria categoriaBase = categoriaDAO.getById(categoria.getId());
		categoriaBase.setSubCategorias(new ArrayList<SubCategoria>());
			
		try {
			//Adiciona as subcategorias selecionadas a lista subCategorias da categoria
			for(String subCategoria : categoria.getSubCategoriasAtivas()){
				categoriaBase.getSubCategorias().add(subCategoriaDAO.getByNome(subCategoria));
			}
		
			categoriaDAO.gravar(categoriaBase);
			response.setValidated(true);
			response.setMessage("Sub-Categorias vinculadas/desvinculadas com sucesso");
		} catch (Exception e) {
			Map<String, String> errors = new HashMap<String, String>();
			errors.put("subCategoria", "Ops... Ocorreu um erro. Tente novamente. ");
			errors.put("erro", e.getMessage());
			response.setValidated(false);
			response.setErrorMessages(errors);			
		}	
		return response;
	}	
	
}
