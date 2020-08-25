package br.gov.rs.parobe.helpdesk.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

@Entity
public class Setor {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@NotNull(message = "O Campo nome é obrigatório")
	@Length(min = 6, max = 50, message = "O nome deve conter no mínimo 6 caracteres")
	private String nome;
	
	@Length(max = 50, message = "O campo descrição deve conter entre 6 e 50 caracteres")
	private String descricao;
	
	private boolean status;
	
	@OneToMany( mappedBy = "setor", cascade = CascadeType.MERGE)
	private List<Usuario> usuarios = new ArrayList<Usuario>();
	
	@OneToMany( mappedBy = "setor", cascade = CascadeType.MERGE)
	private List<Chamado> chamados = new ArrayList<Chamado>();
		 
	public Setor() {
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
	
	public List<Usuario> getUsuarios() {
		return usuarios;
	}

	public void setUsuarios(List<Usuario> usuarios) {
		this.usuarios = usuarios;
	}

	public void atualizaDados(Setor setorAlt) {
		this.nome = setorAlt.getNome();
		this.descricao = setorAlt.getDescricao();
		this.status = setorAlt.isStatus();
	}


}