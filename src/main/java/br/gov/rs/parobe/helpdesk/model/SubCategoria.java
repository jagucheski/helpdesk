package br.gov.rs.parobe.helpdesk.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "sub_categoria")
public class SubCategoria {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@NotNull(message = "O Campo nome é obrigatório")
	@Length(min = 3, max = 50, message = "O nome deve conter no mínimo 6 caracteres")
	private String nome;
	
	private boolean status;
	
	@ManyToMany(mappedBy="subCategorias")
	private List<Categoria> categorias = new ArrayList<Categoria>();
	
	@OneToMany( mappedBy = "subCategoria", cascade = CascadeType.MERGE)
	private List<Chamado> chamados = new ArrayList<Chamado>();
	 
	public SubCategoria() {
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
	 
	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}
	
	public List<Categoria> getCategorias() {
		return categorias;
	}

	public void setCategorias(List<Categoria> categorias) {
		this.categorias = categorias;
	}
	
	public List<Chamado> getChamados() {
		return chamados;
	}

	public void setChamados(List<Chamado> chamados) {
		this.chamados = chamados;
	}

	public void atualizaDados(SubCategoria subCategoriaAlt) {
		this.nome = subCategoriaAlt.getNome();
		this.status = subCategoriaAlt.isStatus();
	}
	
}
