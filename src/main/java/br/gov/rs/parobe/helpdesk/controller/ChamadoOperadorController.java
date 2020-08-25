package br.gov.rs.parobe.helpdesk.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
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
import org.springframework.web.bind.annotation.PathVariable;
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
import br.gov.rs.parobe.helpdesk.dao.SetorDAO;
import br.gov.rs.parobe.helpdesk.dao.SolicitanteDAO;
import br.gov.rs.parobe.helpdesk.dao.SubCategoriaDAO;
import br.gov.rs.parobe.helpdesk.dao.TipoCategoriaDAO;
import br.gov.rs.parobe.helpdesk.jsonResponse.ChamadoSolicitanteJsonResponse;
import br.gov.rs.parobe.helpdesk.jsonResponse.MensagemJsonResponse;
import br.gov.rs.parobe.helpdesk.jsonResponse.SubCategoriaJsonResponse;
import br.gov.rs.parobe.helpdesk.model.Categoria;
import br.gov.rs.parobe.helpdesk.model.Chamado;
import br.gov.rs.parobe.helpdesk.model.Mensagem;
import br.gov.rs.parobe.helpdesk.model.Setor;
import br.gov.rs.parobe.helpdesk.model.StatusChamado;
import br.gov.rs.parobe.helpdesk.model.SubCategoria;
import br.gov.rs.parobe.helpdesk.model.TipoCategoria;
import br.gov.rs.parobe.helpdesk.model.Usuario;

@Controller
public class ChamadoOperadorController {

	@Autowired
	private ChamadoDAO chamadoDAO;

	@Autowired
	private ChamadoSolicitanteDAO chamadoSolicitanteDAO;

	@Autowired
	private CategoriaDAO categoriaDAO;
	
	@Autowired
	private SubCategoriaDAO subCategoriaDAO;

	@Autowired
	private TipoCategoriaDAO tipoCategoriaDAO;

	@Autowired
	private SetorDAO setorDAO;

	@Autowired
	private MensagemDAO mensagemDAO;
	
	@Autowired
	private SolicitanteDAO solicitanteDAO;
	
	@RequestMapping(value = "/chamadoOperador", method = RequestMethod.GET)
	public ModelAndView chamadoOperador() throws ParseException {
		ModelAndView modelAndView = new ModelAndView("chamado/chamadoOperador","chamadoSolicitante", new Chamado());
		List<Chamado> chamados = chamadoDAO.findChamadoOperador(StatusChamado.AGUARDANDO_ATENDIMENTO.getValor(),LocalDate.now().getYear(),"","");
		List<Categoria> categorias = categoriaDAO.getCategorias();
		List<TipoCategoria> tipoCategorias = tipoCategoriaDAO.getTipoCategorias();
		List<Setor> setores = setorDAO.getSetores();
		modelAndView.addObject("categorias", categorias);
		modelAndView.addObject("tipoCategorias", tipoCategorias);
		modelAndView.addObject("chamados", chamados);
		modelAndView.addObject("setores", setores);
		modelAndView.addObject("statusChamado", StatusChamado.values());
		return modelAndView;
	}
		
	@RequestMapping(value="/chamadoOperador/pesquisar" , method = RequestMethod.POST)
	public ModelAndView pesquisar(@RequestParam(value="statusFind", required=false) String statusFind,
								  @RequestParam(value="dataAberturaFind", required=false) Integer anoAberturaFind,
								  @RequestParam(value="descricaoFind", required=false) String descricaoFind, 
								  @RequestParam(value="solicitanteFind", required=false) String solicitanteFind) 
										  throws ParseException {
		ModelAndView modelAndView = new ModelAndView("chamado/chamadoOperador","chamadoSolicitante", new Chamado());
		List<Chamado> chamados = chamadoDAO.findChamadoOperador(statusFind, anoAberturaFind, descricaoFind, solicitanteFind);
		List<Categoria> categorias = categoriaDAO.getCategorias();
		List<TipoCategoria> tipoCategorias = tipoCategoriaDAO.getTipoCategorias();
		List<Setor> setores = setorDAO.getSetores();		
		modelAndView.addObject("categorias", categorias);
		modelAndView.addObject("tipoCategorias", tipoCategorias);
		modelAndView.addObject("chamados", chamados);
		modelAndView.addObject("setores", setores);
		modelAndView.addObject("statusChamado", StatusChamado.values());
		return modelAndView;
	}	
	
	/**
	 *  Acesso a tela de inicio de atendimento de chamado
	 * 
	 *  Permissão de acesso: SUP
	 **/
	@RequestMapping(value="/chamadoOperador/chamadoIniciarAtendimento/{id}" , method = RequestMethod.GET)
	public ModelAndView chamadoIniciarAtendimento(@PathVariable("id") int id) {
		ModelAndView modelAndView = new ModelAndView("chamado/chamadoIniciarAtendimento");
		List<Categoria> categorias = categoriaDAO.getCategorias();
		List<SubCategoria> subCategorias = subCategoriaDAO.getSubCategorias();
		List<TipoCategoria> tipoCategorias = tipoCategoriaDAO.getTipoCategorias();
		List<Setor> setores = setorDAO.getSetores();
		Chamado chamadoSolicitante = chamadoSolicitanteDAO.getOne(id);
		chamadoSolicitante.setCategoriaSelect(chamadoSolicitante.getCategoria().getNome());
		chamadoSolicitante.setSubCategoriaSelect(chamadoSolicitante.getSubCategoria().getNome());
		chamadoSolicitante.setTipoCategoriaSelect(chamadoSolicitante.getTipoCategoria().getNome());

		if(chamadoSolicitante.getSetor()!=null)
			chamadoSolicitante.setSetorSelect(chamadoSolicitante.getSetor().getNome());
				
		modelAndView.addObject("chamadoSolicitante", chamadoSolicitante);
		modelAndView.addObject("categorias", categorias);
		modelAndView.addObject("subCategorias", subCategorias);
		modelAndView.addObject("tipoCategorias", tipoCategorias);
		modelAndView.addObject("setores", setores);
		return modelAndView;
	}

	/**
	 *  Acesso a tela de mensagens do chamado
	 * 
	 *  Permissão de acesso: SUP
	 **/
	@RequestMapping(value="/chamadoOperador/mensagensChamadoOperador/" , method = RequestMethod.GET)
	public ModelAndView mensagensChamadoOperador(@RequestParam(value="codigo", required=true) int id) {
		ModelAndView modelAndView = new ModelAndView("mensagem/mensagensChamadoOperador");
		Chamado chamado = chamadoSolicitanteDAO.getOne(id);
		Mensagem mensagem = new Mensagem(chamado);
		List<Mensagem> mensagens =mensagemDAO.getMensagensChamados(chamado);
		modelAndView.addObject("chamadoSolicitante", chamado);
		modelAndView.addObject("mensagem", mensagem);
		modelAndView.addObject("mensagens", mensagens);
		return modelAndView;
	}

	
	/**
	 * Excluir chamdo solicitante através do mapping chamadoOperador/excluir 
	 * Somente é chamado quando não o status é Aguarndando atendimento
	 *  Permissão de acesso:  SUP
	 **/
	@Transactional
	@PostMapping(value="/chamadoOperador/excluir", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public ChamadoSolicitanteJsonResponse excluir(@ModelAttribute Chamado chamadoExcluir) {
		ChamadoSolicitanteJsonResponse response = new ChamadoSolicitanteJsonResponse();
		Chamado chamado = chamadoSolicitanteDAO.getByChamado(chamadoExcluir);
		if(!chamado.getStatus().equals(StatusChamado.AGUARDANDO_ATENDIMENTO.getValor())) {
			Map<String, String> errors = new HashMap<String, String>();
			response.setValidated(false);
			errors.put("chamadoStatus", "Ops.. Não é possível excluir este chamado.");
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
	  * Carrega a descricao do chamado selecionado para edição
	 * 
	 **/
	@RequestMapping(value = "/chamadoOperador/carregaDescricaoChamado", method = RequestMethod.GET)
	@ResponseBody
	public ChamadoSolicitanteJsonResponse carregaDescricaoChamado(@RequestParam(value="val") String idCategoria) {
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
	 * Inicia atendimento do chamado 
	 * Atualiza status do chamado e campos editados pelo operador e cria mensagem de inicio de atendimento
	 *  Permissão de acesso:  SUP
	 **/
	@Transactional
	@PostMapping(value="/chamadoOperador/iniciarAtendimentoChamado/", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public ChamadoSolicitanteJsonResponse iniciarAtendimentoChamado(@ModelAttribute @Valid Chamado chamadoIniciaAtendimento, BindingResult result) {
		ChamadoSolicitanteJsonResponse response = new ChamadoSolicitanteJsonResponse();
		Map<String, String> erros = validaChamadoIniciarAtendimento(chamadoIniciaAtendimento);
		try {
			if(!erros.isEmpty()){
				response.setValidated(false);
				response.setErrorMessages(erros);
			}else if(chamadoIniciaAtendimento.isChamadoConcluido()){
				chamadoSolicitanteDAO.gravar(preparaChamadoIniciarAtendimentoConcluido(chamadoIniciaAtendimento));
				Mensagem mensagemInicioAtemdimentoChamado = preparaMensagemInicioAtendimentoChamado(chamadoIniciaAtendimento);
				Mensagem mensagemChamadoConcluido = preparaMensagemChamadoConcluido(chamadoIniciaAtendimento);
				mensagemDAO.gravar(mensagemInicioAtemdimentoChamado);
				mensagemDAO.gravar(mensagemChamadoConcluido);
				response.setValidated(true);
				response.setMessage("Chamado concluido com sucesso! Você será redirecionado...");
			}else {
				Chamado chamado =  preparaChamadoIniciarAtendimento(chamadoIniciaAtendimento);
				chamadoSolicitanteDAO.gravar(chamado);
				
				Mensagem mensagem = preparaMensagemInicioAtendimento(chamado);
				mensagemDAO.gravar(mensagem);
				
				response.setValidated(true);
			    response.setMessage("Atendimento iniciado. Você será redirecionado...");
			}
		} catch (Exception e) {
			Map<String, String> errors = new HashMap<String, String>();
			response.setValidated(false);
			errors.put("chamadoError", "Ops.. Ocorreu um erro. Tente novamente.");
			response.setErrorMessages(errors);
		}
		return response;
	}
	
	/**
	 * Finaliza atendimento do chamado 
	 * Atualiza status do chamado e cria mensagem de chamado conluido
	 *  Permissão de acesso:  SUP
	 **/
	@Transactional
	@PostMapping(value="/chamadoOperador/finalizarAtendimentoChamado/", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public ChamadoSolicitanteJsonResponse finalizarAtendimentoChamado(@ModelAttribute Chamado chamadoFinalizar) {
		ChamadoSolicitanteJsonResponse response = new ChamadoSolicitanteJsonResponse();
		
		if(chamadoFinalizar.getDescricao().isEmpty()) {
			Map<String, String> errors = new HashMap<String, String>();
			response.setValidated(false);
			errors.put("chamadoDesc", "Campo Mensagem é obrigatório. Insira uma menagem.");
			response.setErrorMessages(errors);		
		}else {
			Chamado chamado = chamadoSolicitanteDAO.getByChamado(chamadoFinalizar);
			if(chamado.getStatus().equals(StatusChamado.AGUARDANDO_ATENDIMENTO.getValor()) || chamado.getStatus().equals(StatusChamado.CONCLUIDO.getValor()) ) {
				Map<String, String> errors = new HashMap<String, String>();
				response.setValidated(false);
				errors.put("chamadoStatus", "Ops.. Não é possível finalizar este chamado.");
				response.setErrorMessages(errors);			
			}else {
				try {
					chamado.setStatus(StatusChamado.CONCLUIDO.getValor());
					chamado.setDataEncerramento(new Date());
					chamadoSolicitanteDAO.gravar(chamado);
					
					Mensagem mensagem = preparaMensagemFinalizarAtendimento(chamado, chamadoFinalizar.getDescricao());
					mensagemDAO.gravar(mensagem);
					
					response.setValidated(true);
					response.setMessage("Chamado finalizado com sucesso!");
				} catch (Exception e) {
					Map<String, String> errors = new HashMap<String, String>();
					response.setValidated(false);
					errors.put("chamadoError", "Ops.. Ocorreu um erro. Tente novamente." +  e.getMessage().toString());
					response.setErrorMessages(errors);			
				}
			}
		}
		return response;
	}
	
	/**
	 * Adiciona mensagem ao chamado
	 *  Permissão de acesso:  SUP
	 **/
	@Transactional
	@RequestMapping(value="/chamadoOperador/adicionarMensagem", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public MensagemJsonResponse adicionarMensagem(@ModelAttribute Mensagem mensagem) {
		MensagemJsonResponse response = new MensagemJsonResponse();
		
		if(mensagem.getDescricao().isEmpty()) {
			Map<String, String> errors = new HashMap<String, String>();
			response.setValidated(false);
			errors.put("mensagemDescricao", "Insira uma mensagem.");
			response.setErrorMessages(errors);		
		}else {
			try {
				mensagemDAO.gravar(preparaMensagemAdicionar(mensagem));
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
	 * Adicionar novo chamadoSolicitante /adicionar 
	 * 
	 *  Permissão de acesso:  SUP
	 **/
	@Transactional
	@PostMapping(value="/chamadoOperador/adicionarChamadoSolicitante", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public ChamadoSolicitanteJsonResponse adicionarChamadoSolicitante(@ModelAttribute @Valid Chamado chamado, BindingResult result) {
		ChamadoSolicitanteJsonResponse response = new ChamadoSolicitanteJsonResponse();
		Map<String, String> erros = validaChamadoSolicitante(chamado);
		try {
			if(!erros.isEmpty()){
				response.setValidated(false);
				response.setErrorMessages(erros);
			}else if(chamado.isChamadoConcluido()){
				chamadoSolicitanteDAO.gravar(preparaChamadoConcluidoSolicitante(chamado));
				Mensagem mensagem = preparaMensagemChamadoConcluido(chamado);
				mensagemDAO.gravar(mensagem);
				response.setValidated(true);
				response.setMessage("Chamado finalizado com sucesso!");
			}else {
				chamadoSolicitanteDAO.gravar(preparaChamadoSolicitante(chamado));
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
	 * Carrega campo usuario autocomplete
	 **/
	@Transactional
	@RequestMapping(value = "/chamadoOperador/searchSolicitanteAutocomplete", method = RequestMethod.GET, headers="Accept=*/*")
	@ResponseBody
	public List<String> searchSolicitanteAutocomplete(@RequestParam("term")String nome) {
	 	return solicitanteDAO.searchSolicitanteAutocomplete(nome.replace(",", ""));
	}
	
	/**
	 * Carrega as subcategoria associadas a categoria selecionada
	 * 
	 **/
	@RequestMapping(value = "/chamadoOperador/carregaSubCategoria", method = RequestMethod.GET)
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
	 * Carrega campos da base no objeto chamado criado para salvar
	 **/
	private Chamado preparaChamadoIniciarAtendimento(Chamado chamadoIniciaAtendimento) {
		Chamado chamado = chamadoSolicitanteDAO.getOne(chamadoIniciaAtendimento.getId());
		chamado.setCategoria(categoriaDAO.getByNome(chamadoIniciaAtendimento.getCategoriaSelect()));
		chamado.setSubCategoria(subCategoriaDAO.getByNome(chamadoIniciaAtendimento.getSubCategoriaSelect()));
		chamado.setTipoCategoria(tipoCategoriaDAO.getByNome(chamadoIniciaAtendimento.getTipoCategoriaSelect()));
		chamado.setSetor(setorDAO.getByNome(chamadoIniciaAtendimento.getSetorSelect()));
		chamado.setStatus(StatusChamado.ATENDIMENTO.getValor());		
		return chamado;
	}
	
	/**
	 * Carrega campos da base no objeto chamado criado para salvar
	 * @throws ParseException 
	 **/
	private Chamado preparaChamadoIniciarAtendimentoConcluido(Chamado chamadoIniciaAtendimento) throws ParseException {
		Chamado chamado = chamadoSolicitanteDAO.getOne(chamadoIniciaAtendimento.getId());
		chamado.setCategoria(categoriaDAO.getByNome(chamadoIniciaAtendimento.getCategoriaSelect()));
		chamado.setSubCategoria(subCategoriaDAO.getByNome(chamadoIniciaAtendimento.getSubCategoriaSelect()));
		chamado.setTipoCategoria(tipoCategoriaDAO.getByNome(chamadoIniciaAtendimento.getTipoCategoriaSelect()));
		chamado.setSetor(setorDAO.getByNome(chamadoIniciaAtendimento.getSetorSelect()));
		chamado.setStatus(StatusChamado.CONCLUIDO.getValor());
			
	    SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd HH:mm");  
		chamado.setDataEncerramento(formatter.parse(chamadoIniciaAtendimento.getDataFim()+" "+chamadoIniciaAtendimento.getHoraFim()));
		
		return chamado;
	}
	
	/**
	 * Carrega campos da base no objeto chamado criado para salvar
	 **/
	private Chamado preparaChamadoSolicitante(Chamado chamado) {
		Usuario usuario = solicitanteDAO.getByEmail(chamado.getSolicitanteSelect().split("-")[1]);
		chamado.setSolicitante(usuario);
		chamado.setCategoria(categoriaDAO.getByNome(chamado.getCategoriaSelect()));
		chamado.setSubCategoria(subCategoriaDAO.getByNome(chamado.getSubCategoriaSelect()));
		chamado.setTipoCategoria(tipoCategoriaDAO.getByNome(chamado.getTipoCategoriaSelect()));
		chamado.setStatus(StatusChamado.AGUARDANDO_ATENDIMENTO.getValor());
		chamado.setSetor(setorDAO.getByNome(chamado.getSetorSelect()));
		chamado.setDataAbertura(new Date());
		chamado.setDescricao(chamado.getDescricao().replace("\"", "").replace("\'", ""));
		return chamado;
	}
	
	/**
	 * Carrega campos da base no objeto chamado criado para salvar como concluido
	 * @throws ParseException 
	 **/
	private Chamado preparaChamadoConcluidoSolicitante(Chamado chamado) throws ParseException {
		Usuario usuario = solicitanteDAO.getByEmail(chamado.getSolicitanteSelect().split("-")[1]);
		chamado.setSolicitante(usuario);
		chamado.setCategoria(categoriaDAO.getByNome(chamado.getCategoriaSelect()));
		chamado.setSubCategoria(subCategoriaDAO.getByNome(chamado.getSubCategoriaSelect()));
		chamado.setTipoCategoria(tipoCategoriaDAO.getByNome(chamado.getTipoCategoriaSelect()));
		chamado.setStatus(StatusChamado.CONCLUIDO.getValor());
		chamado.setSetor(setorDAO.getByNome(chamado.getSetorSelect()));
		
		
	    SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd HH:mm");  
	    Date inicio=formatter.parse(chamado.getDataInicio()+" "+chamado.getHoraInicio());  
	    Date fim=formatter.parse(chamado.getDataFim()+" "+chamado.getHoraFim());  
		
		chamado.setDataAbertura(inicio);
		chamado.setDataEncerramento(fim);
		
		chamado.setDescricao(chamado.getDescricao().replace("\"", "").replace("\'", ""));
		return chamado;
	}


	/**
	 * prepara mensagem de inicio de antedimento
	 **/
	private Mensagem preparaMensagemInicioAtendimento(Chamado chamado) {
		Mensagem mensagem = new Mensagem();
		mensagem.setChamado(chamado);
		mensagem.setData(new Date());
		mensagem.setUsuario((Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		mensagem.setDescricao("Inicio do atendimento.");
		return mensagem;
	}
	
	/**
	 * prepara mensagem de antedimento
	 **/
	private Mensagem preparaMensagemAdicionar(Mensagem mensagem) {
		Chamado chamado = chamadoDAO.getOne(mensagem.getChamado().getId());
		
		if(!mensagem.getStatusChamado().isEmpty())
			chamado.setStatus(mensagem.getStatusChamado());
		
		if(mensagem.getStatusChamado().equals(StatusChamado.AGUARDANDO_RETORNO.getValor())) {
			mensagem.setDescricao(mensagem.getDescricao()+ "\nObs.: " + StatusChamado.AGUARDANDO_RETORNO.getValor());
		}	
		
		mensagem.setChamado(chamado);
		mensagem.setUsuario((Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		mensagem.setData(new Date());
		return mensagem;
	}
	
	/**
	 * prepara mensagem de finalizar de antedimento
	 **/
	private Mensagem preparaMensagemFinalizarAtendimento(Chamado chamado, String descricaoMensagem) {
		Mensagem mensagem = new Mensagem();
		mensagem.setChamado(chamado);
		mensagem.setData(new Date());
		mensagem.setUsuario((Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		mensagem.setDescricao(descricaoMensagem + "\nObs.: Chamado concluído.");
		return mensagem;
	}
	
	/**
	 * prepara mensagem de chamado concluido
	 * @throws ParseException 
	 **/
	private Mensagem preparaMensagemChamadoConcluido(Chamado chamado) throws ParseException {
		SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd HH:mm");  	
		Mensagem mensagem = new Mensagem();
		mensagem.setChamado(chamado);
		mensagem.setData(chamado.getDataEncerramento());
		mensagem.setData(formatter.parse(chamado.getDataFim()+" "+chamado.getHoraFim()));
		mensagem.setUsuario((Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		mensagem.setDescricao("Obs.: Chamado concluído.");
		return mensagem;
	}
	
	/**
	 * prepara mensagem de inicio de atendimento de chamado concluido
	 * @throws ParseException 
	 **/
	private Mensagem preparaMensagemInicioAtendimentoChamado(Chamado chamado) throws ParseException {		
		SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd HH:mm");  		
		Mensagem mensagem = new Mensagem();
		mensagem.setChamado(chamado);
		mensagem.setData(formatter.parse(chamado.getDataInicio()+" "+chamado.getHoraInicio()));
		mensagem.setUsuario((Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		mensagem.setDescricao("Obs.: Inicio do atendimento do chamado.");
		return mensagem;
	}
	
	/**
	 * Valida se campos obrigatórios foram preenchidos para inicio de atendimento
	 **/
	private Map<String, String> validaChamadoIniciarAtendimento(Chamado chamado){
		Map<String, String> errors = new HashMap<String, String>();
		
		if(chamado.getCategoriaSelect().isEmpty())
			errors.put("categoria", "O campo Assunto é obrigatório");
		
		if(!chamado.getCategoriaSelect().isEmpty() && chamado.getSubCategoriaSelect().isEmpty())
			errors.put("subCategoria", "O campo Assunto deve ser selecionado corretamente");

		if(chamado.getTipoCategoriaSelect().isEmpty())
			errors.put("tipoCategoria", "O campo Tipo é obrigatório");

		if(chamado.getSetorSelect().isEmpty())
			errors.put("setor", "O campo Setor é obrigatório");
		
		if(chamado.isChamadoConcluido()) {
			if(chamado.getDataInicio().isEmpty() || chamado.getHoraInicio().isEmpty()) 
				errors.put("dataInicio", "O campo Inicio deve ser preenchido corretamente");

			if(chamado.getDataFim().isEmpty() || chamado.getHoraFim().isEmpty()) 
				errors.put("dataFim", "O campo Fim deve ser preenchido corretamente");
		}	
		
		return errors;
	}
	
	/**
	 * Valida se campos obrigatórios foram preenchidos para adicao de chamado de solicitante
	 **/
	private Map<String, String> validaChamadoSolicitante(Chamado chamado){
		Map<String, String> errors = new HashMap<String, String>();
		
		if(chamado.getSolicitanteSelect().isEmpty())
			errors.put("solicitante", "O campo Solicitante é obrigatório");
		
		if(chamado.getCategoriaSelect().isEmpty())
			errors.put("assunto", "O campo Assunto é obrigatório");

		if(!chamado.getCategoriaSelect().isEmpty() && chamado.getSubCategoriaSelect().isEmpty())
			errors.put("subCategoria", "O campo Assunto deve ser selecionado corretamente");

		if(chamado.getTipoCategoriaSelect().isEmpty())
			errors.put("tipoCategoria", "O campo Tipo é obrigatório");

		if(chamado.getDescricao().isEmpty())
			errors.put("descricao", "O campo Descrição é obrigatório");

		if(chamado.getSetorSelect().isEmpty())
			errors.put("setor", "O campo Setor é obrigatório");
		
		if(chamado.isChamadoConcluido()) {
			if(chamado.getDataInicio().isEmpty() || chamado.getHoraInicio().isEmpty()) 
				errors.put("dataInicio", "O campo Inicio deve ser preenchido corretamente");

			if(chamado.getDataFim().isEmpty() || chamado.getHoraFim().isEmpty()) 
				errors.put("dataFim", "O campo Fim deve ser preenchido corretamente");
		}		
		return errors;
	}
	
}
