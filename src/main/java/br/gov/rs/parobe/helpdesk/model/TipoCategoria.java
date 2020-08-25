package br.gov.rs.parobe.helpdesk.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "tipo_categoria")
public class TipoCategoria {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@NotNull(message = "O Campo nome é obrigatório")
	@Length(min = 6, max = 50, message = "O nome deve conter no mínimo 6 caracteres")
	private String nome;
	
	@Length(max = 255, message = "O campo descrição deve conter entre 6 e 50 caracteres")
	private String descricao;
	
	private boolean status;
	
	@OneToMany( mappedBy = "tipoCategoria", cascade = CascadeType.MERGE)
	private List<Chamado> chamados = new ArrayList<Chamado>();
	
	public TipoCategoria() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}
	 
	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	public void atualizaDados(TipoCategoria tipoCategoriaAlt) {
		this.nome = tipoCategoriaAlt.getNome();
		this.descricao = tipoCategoriaAlt.getDescricao();
		this.status = tipoCategoriaAlt.isStatus();
	}
	
}
