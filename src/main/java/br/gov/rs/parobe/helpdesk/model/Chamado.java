package br.gov.rs.parobe.helpdesk.model;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

@Entity
public class Chamado {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@ManyToOne(fetch = FetchType.LAZY)
	private Categoria categoria;

	@NotNull(message = "O Campo Assunto é obrigatório")
	@ManyToOne(fetch = FetchType.LAZY)
	private SubCategoria subCategoria;

	@NotNull(message = "O Campo Tipo é obrigatório")
	@ManyToOne(fetch = FetchType.LAZY)
	private TipoCategoria tipoCategoria;

	@NotNull(message = "O Campo status é obrigatório")
	private String status;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "data_abertura")
	private Date dataAbertura = new Date();
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "data_encerramento")
	private Date dataEncerramento;

	@ManyToOne(fetch = FetchType.LAZY)
	private Usuario solicitante;

	@ManyToOne(fetch = FetchType.LAZY)
	private Setor setor;

	@NotEmpty(message = "O Campo Descrição é obrigatório")
	@Column(columnDefinition = "TEXT")
	private String descricao;

	@OneToMany( mappedBy = "chamado", cascade = CascadeType.MERGE)
	private List<Mensagem> mensagens  = new ArrayList<Mensagem>();

	@Transient
	private String categoriaSelect = "";

	@Transient
	private String subCategoriaSelect = "";

	@Transient
	private String tipoCategoriaSelect = "";

	@Transient
	private String setorSelect = "";
	
	@Transient
	private String solicitanteSelect = "";
	
	@Transient
	private boolean chamadoConcluido = false;
	
	@Transient
	private String dataInicio;
	
	@Transient
	private String dataFim;
	
	@Transient
	private String horaInicio;
	
	@Transient
	private String horaFim;
	

	public Chamado() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Categoria getCategoria() {
		return categoria;
	}

	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
	}

	public SubCategoria getSubCategoria() {
		return subCategoria;
	}

	public void setSubCategoria(SubCategoria subCategoria) {
		this.subCategoria = subCategoria;
	}

	public TipoCategoria getTipoCategoria() {
		return tipoCategoria;
	}

	public void setTipoCategoria(TipoCategoria tipoCategoria) {
		this.tipoCategoria = tipoCategoria;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getDataAbertura() {
		return dataAbertura;
	}

	public void setDataAbertura(Date dataAbertura) {
		this.dataAbertura = dataAbertura;
	}

	public Date getDataEncerramento() {
		return dataEncerramento;
	}

	public void setDataEncerramento(Date dataEncerramento) {
		this.dataEncerramento = dataEncerramento;
	}

	public Usuario getSolicitante() {
		return solicitante;
	}

	public void setSolicitante(Usuario solicitante) {
		this.solicitante = solicitante;
	}

	public Setor getSetor() {
		return setor;
	}

	public void setSetor(Setor setor) {
		this.setor = setor;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	
	public List<Mensagem> getMensagens() {
		return mensagens;
	}

	public void setMensagens(List<Mensagem> mensagens) {
		this.mensagens = mensagens;
	}

	public String getCategoriaSelect() {
		return categoriaSelect;
	}

	public void setCategoriaSelect(String categoriaSelect) {
		this.categoriaSelect = categoriaSelect;
	}

	public String getSubCategoriaSelect() {
		return subCategoriaSelect;
	}

	public void setSubCategoriaSelect(String subCategoriaSelect) {
		this.subCategoriaSelect = subCategoriaSelect;
	}

	public String getTipoCategoriaSelect() {
		return tipoCategoriaSelect;
	}

	public void setTipoCategoriaSelect(String tipoCategoriaSelect) {
		this.tipoCategoriaSelect = tipoCategoriaSelect;
	}
	
	public String getSetorSelect() {
		return setorSelect;
	}

	public void setSetorSelect(String setorSelect) {
		this.setorSelect = setorSelect;
	}
	
	public String getSolicitanteSelect() {
		return solicitanteSelect;
	}

	public void setSolicitanteSelect(String solicitanteSelect) {
		this.solicitanteSelect = solicitanteSelect;
	}
	
	public boolean isChamadoConcluido() {
		return chamadoConcluido;
	}

	public void setChamadoConcluido(boolean chamadoConcluido) {
		this.chamadoConcluido = chamadoConcluido;
	}

	public String getDataInicio() {
		return dataInicio;
	}

	public void setDataInicio(String dataInicio) {
		this.dataInicio = dataInicio;
	}

	public String getDataFim() {
		return dataFim;
	}

	public void setDataFim(String dataFim) {
		this.dataFim = dataFim;
	}

	public String getHoraInicio() {
		return horaInicio;
	}

	public void setHoraInicio(String horaInicio) {
		this.horaInicio = horaInicio;
	}

	public String getHoraFim() {
		return horaFim;
	}

	public void setHoraFim(String horaFim) {
		this.horaFim = horaFim;
	}

	public String getCategoriaSubDesc() {
		String categoriaSubDesc = this.categoria.getNome() + "/" +this.subCategoria.getNome();
		return (categoriaSubDesc.length() >= 30) ?  categoriaSubDesc.substring(0,30)+" ..." : categoriaSubDesc;
	}
	
	public String getDescricaoDesc() {
		return (this.descricao.length() >= 30) ?  this.descricao.substring(0,30)+" ..." : this.descricao;
	}

	public String getDataAberturaDesc() {
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");  
        return dateFormat.format(this.dataAbertura);
	}
	
	public String getDataEncerramentoDesc() {
		String retorno = "";
		if(this.dataEncerramento!=null) {
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");  
			retorno =  dateFormat.format(this.dataEncerramento);
		}
		return retorno;
	}
	
	public Integer getNumeroMensagens() {
		return this.mensagens.size() + 1 ;
	}
}
