package br.gov.rs.parobe.helpdesk.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

@Entity
public class Categoria {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@NotNull(message = "O Campo nome é obrigatório")
	@Length(min = 6, max = 50, message = "O nome deve conter no mínimo 6 caracteres")
	private String nome;

	private boolean status;

	@ManyToMany(fetch = FetchType.EAGER, cascade = { CascadeType.MERGE })
	@JoinTable(name = "categoria_sub_categoria", joinColumns = {
			@JoinColumn(name = "categoria_id", referencedColumnName = "id") }, inverseJoinColumns = {
					@JoinColumn(name = "sub_categoria_id", referencedColumnName = "id") })
	private List<SubCategoria> subCategorias = new ArrayList<SubCategoria>();

	@OneToMany( mappedBy = "categoria", cascade = CascadeType.MERGE)
	private List<Chamado> chamados = new ArrayList<Chamado>();
	
	@Transient
	private List<String> subCategoriasAtivas = new ArrayList<String>();

	public Categoria() {
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

	public List<SubCategoria> getSubCategorias() {
		return subCategorias;
	}

	public void setSubCategorias(List<SubCategoria> subCategorias) {
		this.subCategorias = subCategorias;
	}

	public List<String> getSubCategoriasAtivas() {
		return subCategoriasAtivas;
	}

	public void setSubCategoriasAtivas(List<String> subCategoriasAtivas) {
		this.subCategoriasAtivas = subCategoriasAtivas;
	}
	
	public List<Chamado> getChamados() {
		return chamados;
	}

	public void setChamados(List<Chamado> chamados) {
		this.chamados = chamados;
	}

	public void atualizaDados(Categoria categoriaAlt) {
		this.nome = categoriaAlt.getNome();
		this.status = categoriaAlt.isStatus();
	}

	/**
	 * Alimenta lista de subCategorias para checkbox
	 */
	public void preparaSubCategoriaList() {
		for (SubCategoria sc : this.getSubCategorias()) {
			this.getSubCategoriasAtivas().add(sc.getNome());
		}
	}

}
