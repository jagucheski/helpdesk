package br.gov.rs.parobe.helpdesk.controller;

import java.text.ParseException;
import java.util.Date;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import br.gov.rs.parobe.helpdesk.dao.CategoriaDAO;
import br.gov.rs.parobe.helpdesk.dao.ChamadoDAO;
import br.gov.rs.parobe.helpdesk.dao.ChamadoSolicitanteDAO;
import br.gov.rs.parobe.helpdesk.dao.MensagemDAO;
import br.gov.rs.parobe.helpdesk.dao.SubCategoriaDAO;
import br.gov.rs.parobe.helpdesk.dao.TipoCategoriaDAO;
import br.gov.rs.parobe.helpdesk.jsonResponse.ChamadoSolicitanteJsonResponse;
import br.gov.rs.parobe.helpdesk.jsonResponse.MensagemJsonResponse;
import br.gov.rs.parobe.helpdesk.jsonResponse.SubCategoriaJsonResponse;
import br.gov.rs.parobe.helpdesk.model.Categoria;
import br.gov.rs.parobe.helpdesk.model.Chamado;
import br.gov.rs.parobe.helpdesk.model.Mensagem;
import br.gov.rs.parobe.helpdesk.model.StatusChamado;
import br.gov.rs.parobe.helpdesk.model.SubCategoria;
import br.gov.rs.parobe.helpdesk.model.TipoCategoria;
import br.gov.rs.parobe.helpdesk.model.Usuario;

@Controller
public class ChamadoSolicitanteController {

	@Autowired
	private ChamadoSolicitanteDAO chamadoSolicitanteDAO;

	@Autowired
	private CategoriaDAO categoriaDAO;
	
	@Autowired
	private SubCategoriaDAO subCategoriaDAO;

	@Autowired
	private TipoCategoriaDAO tipoCategoriaDAO;
	
	@Autowired
	private MensagemDAO mensagemDAO;
	
	@Autowired
	private ChamadoDAO chamadoDAO;
	
	@RequestMapping(value = "/chamadoSolicitante", method = RequestMethod.GET)
	public ModelAndView chamadoSolicitante() {
		Usuario solicitante = (Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<Categoria> categorias = categoriaDAO.getCategorias();
		List<TipoCategoria> tipoCategorias = tipoCategoriaDAO.getTipoCategorias();
		List<Chamado> chamados = chamadoSolicitanteDAO.getChamadosSolicitante(solicitante);
		ModelAndView modelAndView = new ModelAndView("chamado/chamadoSolicitante","chamadoSolicitante", new Chamado());
		modelAndView.addObject("categorias", categorias);
		modelAndView.addObject("tipoCategorias", tipoCategorias);
		modelAndView.addObject("chamados", chamados);
		modelAndView.addObject("statusChamado", StatusChamado.values());
		return modelAndView;
	}
	
	/**
	 *  Acesso a tela de mensagens do chamado do solicitante
	 * 
	 *  Permissão de acesso: USER
	 **/
	@RequestMapping(value="/chamadoSolicitante/mensagensChamadoSolicitante/" , method = RequestMethod.GET)
	public ModelAndView mensagensChamadoSolicitante(@RequestParam(value="codigo", required=true) int id) {
		ModelAndView modelAndView = new ModelAndView("mensagem/mensagensChamadoSolicitante");
		Usuario solicitante = (Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Chamado chamado = chamadoSolicitanteDAO.getByIdEmail(id, solicitante.getEmail());
		Mensagem mensagem = new Mensagem(chamado);
		List<Mensagem> mensagens =mensagemDAO.getMensagensChamados(chamado);
		modelAndView.addObject("chamadoSolicitante", chamado);
		modelAndView.addObject("mensagem", mensagem);
		modelAndView.addObject("mensagens", mensagens);
		return modelAndView;
	}
		
	@RequestMapping(value="/chamadoSolicitante/pesquisar" , method = RequestMethod.POST)
	public ModelAndView pesquisar(@RequestParam(value="statusFind", required=false) String statusFind,
								  @RequestParam(value="dataAberturaFind", required=false) String dataAberturaFind,
								  @RequestParam(value="descricaoFind", required=false) String descricaoFind) throws ParseException {
		Usuario solicitante = (Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<Categoria> categorias = categoriaDAO.getCategorias();
		List<TipoCategoria> tipoCategorias = tipoCategoriaDAO.getTipoCategorias();
		List<Chamado> chamados = chamadoSolicitanteDAO.findChamadoSolicitante(solicitante, statusFind, dataAberturaFind, descricaoFind);
		ModelAndView modelAndView = new ModelAndView("chamado/chamadoSolicitante","chamadoSolicitante", new Chamado());
		modelAndView.addObject("categorias", categorias);
		modelAndView.addObject("tipoCategorias", tipoCategorias);
		modelAndView.addObject("chamados", chamados);
		modelAndView.addObject("statusChamado", StatusChamado.values());
		return modelAndView;
	}
	
	/**
	 * Carrega as subcategoria associadas a categoria selecionada
	 * 
	 **/
	@RequestMapping(value = "/chamadoSolicitante/carregaSubCategoria", method = RequestMethod.GET)
	@ResponseBody
	public SubCategoriaJsonResponse carregaSubCategoria(@RequestParam(value="val") String nomeCategoria) {
		SubCategoriaJsonResponse response = new SubCategoriaJsonResponse();
		try {
			Categoria categoria = categoriaDAO.getByNome(nomeCategoria.substring(1, nomeCategoria.length())); 
			Map<Integer, String> subCategorias = categoria.getSubCategorias().stream().collect(Collectors.toMap(SubCategoria :: getId, SubCategoria :: getNome));
			response.setSubCategorias(subCategorias);
			response.setValidated(true);
			response.setMessage("Sub-Categoria excluída com sucesso!");
		} catch (Exception e) {
			response.setValidated(false);
			Map<String, String> errors = new HashMap<String, String>();
			errors.put("categoria", "Erro categoria!");
            response.setValidated(false);
	        response.setErrorMessages(errors);
		}
		return response;
	}

	/**
	 * Carrega a descricao do chamado selecionado para edição
	 * 
	 **/
	@RequestMapping(value = "/chamadoSolicitante/carregaDescricaoChamadoSolicitante", method = RequestMethod.GET)
	@ResponseBody
	public ChamadoSolicitanteJsonResponse carregaDescricaoChamadoSolicitante(@RequestParam(value="val") String idCategoria) {
		ChamadoSolicitanteJsonResponse response = new ChamadoSolicitanteJsonResponse();
		try {
			Chamado chamado = chamadoSolicitanteDAO.getOne(Integer.valueOf(idCategoria.replaceAll(",", "")));
			response.setDescricaoChamado(chamado.getDescricao());
			response.setValidated(true);
		} catch (Exception e) {
			response.setValidated(false);
			Map<String, String> errors = new HashMap<String, String>();
			errors.put("chamado", "Erro ao caregar o chamado!");
			response.setValidated(false);
			response.setErrorMessages(errors);
		}
		return response;
	}
	
	/**
	 * Adicionar novo chamadoSolicitante /adicionar 
	 * 
	 *  Permissão de acesso:  USER
	 **/
	@Transactional
	@PostMapping(value="/chamadoSolicitante/adicionar", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public ChamadoSolicitanteJsonResponse adicionar(@ModelAttribute @Valid Chamado chamado, BindingResult result) {
		ChamadoSolicitanteJsonResponse response = new ChamadoSolicitanteJsonResponse();
		Map<String, String> erros = validaChamado(chamado);
		try {
			if(!erros.isEmpty()){
				response.setValidated(false);
				response.setErrorMessages(erros);
			}else {
				
				chamadoSolicitanteDAO.gravar(preparaChamado(chamado));
				response.setValidated(true);
			    response.setMessage("Chamado cadastrado com sucesso!");
			}
		} catch (Exception e) {
			Map<String, String> errors = new HashMap<String, String>();
			response.setValidated(false);
			errors.put("chamadoError", "Ops.. Ocorreu um erro. Tente novamente. " + e.getMessage().toString());
			response.setErrorMessages(errors);
		}
		return response;
	}
	
	/**
	 * Excluir chamdo solicitante através do mapping chamadoSolicitante/excluir 
	 * Somente é chamado quando não o status é Aguarndando atendimento
	 *  Permissão de acesso:  USER
	 **/
	@Transactional
	@PostMapping(value="/chamadoSolicitante/excluir", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public ChamadoSolicitanteJsonResponse excluir(@ModelAttribute Chamado chamadoExcluir) {
		ChamadoSolicitanteJsonResponse response = new ChamadoSolicitanteJsonResponse();
		Chamado chamado = chamadoSolicitanteDAO.getByChamado(chamadoExcluir);
		if(!chamado.getStatus().equals(StatusChamado.AGUARDANDO_ATENDIMENTO.getValor())) {
			Map<String, String> errors = new HashMap<String, String>();
			response.setValidated(false);
			errors.put("chamadoStatusr", "Ops.. Não é possível excluir este chamado.");
			response.setErrorMessages(errors);			
		}else {
			try {
				chamadoSolicitanteDAO.deletar(chamado);
				response.setValidated(true);
				response.setMessage("Chamado excluído com sucesso!");
			} catch (Exception e) {
				Map<String, String> errors = new HashMap<String, String>();
				response.setValidated(false);
				errors.put("chamadoError", "Ops.. Ocorreu um erro. Tente novamente." +  e.getMessage().toString());
				response.setErrorMessages(errors);			
			}
		}
		return response;
	}
	
	
	/**
	 * Editar dados do chamado através do mapping chamadoSolicitante/editarChamadoSolicitante 
	 * 
	 *  Permissão de acesso:  USER
	 **/
	@Transactional
	@PostMapping(value="/chamadoSolicitante/editarChamadoSolicitante", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public ChamadoSolicitanteJsonResponse editarChamadoSolicitante(Chamado chamadoAlt) {
		ChamadoSolicitanteJsonResponse response = new ChamadoSolicitanteJsonResponse();
		Map<String, String> errors = new HashMap<String, String>();
		
		if(chamadoAlt.getDescricao().isEmpty()) {
			response.setValidated(false);
			errors.put("chamadoDescricao", "O campo descrição é obrigatório");
			response.setErrorMessages(errors);	
		}else {
			try {
				Chamado chamado = chamadoSolicitanteDAO.getOne(chamadoAlt.getId());
				chamado.setDescricao(chamadoAlt.getDescricao().replace("\"", "").replace("\'", ""));	
				chamadoSolicitanteDAO.gravar(chamado);
				response.setValidated(true);
				response.setMessage("Chamado atualizado com sucesso!");
			} catch (Exception e) {
				response.setValidated(false);
				errors.put("chamadoError", "Ops.. Ocorreu um erro. Tente novamente." +  e.getMessage().toString());
				response.setErrorMessages(errors);			
			}
		}
		return response;
	}
	
	/**
	 * Adiciona mensagem ao chamado
	 *  Permissão de acesso:  USER
	 **/
	@Transactional
	@RequestMapping(value="/chamadoSolicitante/adicionarMensagem", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public MensagemJsonResponse adicionarMensagem(@ModelAttribute Mensagem mensagem) {
		MensagemJsonResponse response = new MensagemJsonResponse();
		Chamado chamado = chamadoDAO.getOne(mensagem.getChamado().getId());
		
		
		if(mensagem.getDescricao().isEmpty()) {
			Map<String, String> errors = new HashMap<String, String>();
			response.setValidated(false);
			errors.put("mensagemDescricao", "Insira uma mensagem.");
			response.setErrorMessages(errors);		
		}else if(chamado.getStatus().equals(StatusChamado.CONCLUIDO.getValor())) {
			Map<String, String> errors = new HashMap<String, String>();
			response.setValidated(false);
			errors.put("concluido", "Chamado concluído pelo operador. Este chamado não permite novas mensagens.");
			response.setErrorMessages(errors);		
		}else{
			try {
				mensagemDAO.gravar(preparaMensagemAdicionar(mensagem, chamado));
				response.setValidated(true);
				response.setMessage("Mensagem adicionada com sucesso!");
			} catch (Exception e) {
				Map<String, String> errors = new HashMap<String, String>();
				response.setValidated(false);
				errors.put("mensagemError", "Ops.. Ocorreu um erro. Tente novamente." +  e.getMessage().toString());
				response.setErrorMessages(errors);			
			}			
		}
		return response;
	}	
	
	/**
	 * prepara mensagem de antedimento
	 **/
	private Mensagem preparaMensagemAdicionar(Mensagem mensagem, 	Chamado chamado) {
		
		if(chamado.getStatus().equals(StatusChamado.AGUARDANDO_RETORNO.getValor()))
			chamado.setStatus(StatusChamado.ATENDIMENTO.getValor());
			
		mensagem.setChamado(chamado);
		mensagem.setUsuario((Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		mensagem.setData(new Date());
		return mensagem;
	}
	
	/**
	 * Carrega campos da base no objeto chamado criado para salvar
	 **/
	private Chamado preparaChamado(Chamado chamado) {
		Usuario usuario = (Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		chamado.setCategoria(categoriaDAO.getByNome(chamado.getCategoriaSelect()));
		chamado.setSubCategoria(subCategoriaDAO.getByNome(chamado.getSubCategoriaSelect()));
		chamado.setTipoCategoria(tipoCategoriaDAO.getByNome(chamado.getTipoCategoriaSelect()));
		chamado.setStatus(StatusChamado.AGUARDANDO_ATENDIMENTO.getValor());
		chamado.setSolicitante(usuario);
		chamado.setDataAbertura(new Date());
		chamado.setDescricao(chamado.getDescricao().replace("\"", "").replace("\'", ""));
		
		if(usuario.getSetor() !=null) {
			chamado.setSetor(usuario.getSetor());
		}
		return chamado;
	}
	
	/**
	 * Valida se campos obrigatórios foram preenchidos
	 **/
	private Map<String, String> validaChamado(Chamado chamado){
		Map<String, String> errors = new HashMap<String, String>();
		
		if(chamado.getCategoriaSelect().isEmpty())
			errors.put("categoria", "O campo Assunto é obrigatório");
		
		if(!chamado.getCategoriaSelect().isEmpty() && chamado.getSubCategoriaSelect().isEmpty())
			errors.put("subCategoria", "O campo Assunto deve ser selecionado corretamente");

		if(chamado.getTipoCategoriaSelect().isEmpty())
			errors.put("tipoCategoria", "O campo Tipo é obrigatório");

		if(chamado.getDescricao().isEmpty())
			errors.put("descricao", "O campo Descrição é obrigatório");
		
		return errors;
	}
}
