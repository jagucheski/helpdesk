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

import br.gov.rs.parobe.helpdesk.dao.TipoCategoriaDAO;
import br.gov.rs.parobe.helpdesk.jsonResponse.TipoCategoriaJsonResponse;
import br.gov.rs.parobe.helpdesk.model.TipoCategoria;

@Controller
public class TipoCategoriaController {

	@Autowired
	private TipoCategoriaDAO tipoCategoriaDAO;
	
	/**
	 *  Acesso ao gerenciamento de tipos de categoria
	 * 
	 *  Permissão de acesso:  SUP
	 **/	
	@RequestMapping(value = "/tipoCategoria", method = RequestMethod.GET)
	public ModelAndView tipoCategoria() {
		List<TipoCategoria> tipoCategorias = tipoCategoriaDAO.getTipoCategorias();
		ModelAndView modelAndView = new ModelAndView("tipoCategoria/tipoCategoria");
		modelAndView.addObject("tipoCategorias", tipoCategorias);
		return modelAndView;
	}
	
	@RequestMapping(value="/tipoCategoria/pesquisarTipoCategoria" , method = RequestMethod.POST)
	public ModelAndView pesquisarTipoCategoria(@RequestParam(value="nomeFind", required=false) String nome,
											   @RequestParam(value="descricaoFind", required=false) String descricao) {
		List<TipoCategoria> tipoCategorias = tipoCategoriaDAO.findByTipoCategoria(nome,descricao);
		ModelAndView modelAndView = new ModelAndView("tipoCategoria/tipoCategoria");
		modelAndView.addObject("tipoCategorias", tipoCategorias);
		return modelAndView;
	}
	
	/**
	 * Adicionar novo tipoCategoria/tipoCategoria 
	 * 
	 *  Permissão de acesso:  SUP
	 **/
	@Transactional
	@PostMapping(value="/tipoCategoria/adicionarTipoCategoria", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public TipoCategoriaJsonResponse adicionarTipoCategoria(@ModelAttribute @Valid TipoCategoria tipoCategoria, BindingResult result) {

		TipoCategoriaJsonResponse response = new TipoCategoriaJsonResponse();
		
		if (result.hasErrors()) {
	         Map<String, String> errors = result.getFieldErrors().stream()
	         .collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));	         
	         response.setValidated(false);
	         response.setErrorMessages(errors);
		} else if(tipoCategoriaDAO.existTipoCategoriaByNome(tipoCategoria.getNome())){
			Map<String, String> errors = new HashMap<String, String>();
			errors.put("nome", "Tipo categoria já cadastrada com este nome!");
            response.setValidated(false);
	        response.setErrorMessages(errors);			
		} else {	
			tipoCategoriaDAO.gravar(tipoCategoria);
			response.setValidated(true);
		    response.setMessage("Tipo Categoria cadastrada com sucesso!");
		}				
		return response;
	}
	
	/**
	 * Excluir tipoCategoria através do mapping /excluirTipoCategoria 
	 * 
	 *  Permissão de acesso:  SUP
	 **/
	@Transactional
	@PostMapping(value="/tipoCategoria/excluirTipoCategoria", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public TipoCategoriaJsonResponse excluirTipoCategoria(@ModelAttribute TipoCategoria tipoCategoriaExcluir) {
		TipoCategoriaJsonResponse response = new TipoCategoriaJsonResponse();
		try {
			//TODO validar se o tipo categoria esta ativo e vinculado a algum chamado
			TipoCategoria tipoCategoria = tipoCategoriaDAO.getOne(tipoCategoriaExcluir);
			tipoCategoriaDAO.deletar(tipoCategoria);
			response.setValidated(true);
			response.setMessage("Tipo Categoria excluída com sucesso!");
		} catch (Exception e) {
			response.setValidated(false);
			response.setMessage("Ops... Ocorreu um erro inesperado.  " + e.getMessage().toString());
		}
		return response;
	}
	
	/**
	 * Editar dados do tipo categoria através do mapping /editarTipoCategoria
	 *  Permissão de acesso:  SUP
	 **/
	@Transactional
	@PostMapping(value="/tipoCategoria/editarTipoCategoria", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public TipoCategoriaJsonResponse editarTipoCategoria(@ModelAttribute @Valid TipoCategoria tipoCategoriaAlt, BindingResult result) {
		
		TipoCategoriaJsonResponse response = new TipoCategoriaJsonResponse();
	
		if (result.hasErrors()) {
			Map<String, String> errors = result.getFieldErrors().stream()
					.collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));	         
			response.setValidated(false);
			response.setErrorMessages(errors);
		}else {	
			TipoCategoria tipoCategoria = tipoCategoriaDAO.getOne(tipoCategoriaAlt);
			tipoCategoria.atualizaDados(tipoCategoriaAlt);
			tipoCategoriaDAO.gravar(tipoCategoria);
			response.setValidated(true);
			response.setMessage("Dados atualizados com sucesso!");			
		}	
		return response;
	}	
	
}
