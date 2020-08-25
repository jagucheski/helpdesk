package br.gov.rs.parobe.helpdesk.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Entity
public class Usuario implements UserDetails {

	private static final long serialVersionUID = 1L;

	@Id
	@NotNull(message = "O Campo email é obrigatório")
	@Length(max = 255)
	@Email(regexp = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$", message = "Email informado é inválido")
	private String email;

	@NotNull(message = "O Campo senha é obrigatório")
	@Length(min = 6, message = "A senha deve conter no mínimo 6 caracteres")
	private String senha;

	@NotNull(message = "O Campo nome é obrigatório")
	@Length(min = 6, max = 50, message = "O nome deve conter no mínimo 6 caracteres")
	private String nome;

	@Length(max = 30, message = "O número de caracteres excede o permitido")
	private String telefone;

	@Length(max = 20, message = "O número de caracteres excede o permitido")
	private String ramal;

	@Value("false")
	@Column(name = "alterar_senha")
	private boolean alterarSenha;

	@OneToMany(fetch = FetchType.EAGER, cascade = { CascadeType.MERGE })
	@JoinTable(name = "usuario_role", joinColumns = {
			@JoinColumn(name = "usuario_email", referencedColumnName = "email") }, inverseJoinColumns = {
					@JoinColumn(name = "roles_nome", referencedColumnName = "nome") })
	private List<Role> roles = new ArrayList<Role>();
	
	@ManyToOne(fetch = FetchType.LAZY)
	private Setor setor;
	
	@OneToMany( mappedBy = "solicitante", cascade = CascadeType.MERGE)
	private List<Chamado> chamados = new ArrayList<Chamado>();
	
    @Transient
	private List<String> perfis = new ArrayList<String>();

	@Transient
	private String emailBase;

	@Transient
	private int setorAtivo;
	
	public Usuario() {
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmailBase() {
		return emailBase;
	}

	public void setEmailBase(String emailBase) {
		this.emailBase = emailBase;
	}
	
	public int getSetorAtivo() {
		return setorAtivo;
	}

	public void setSetorAtivo(int setorAtivo) {
		this.setorAtivo = setorAtivo;
	}

	public List<String> getPerfis() {
		return perfis;
	}

	public void setPerfis(List<String> perfis) {
		this.perfis = perfis;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public boolean isAlterarSenha() {
		return alterarSenha;
	}

	public void setAlterarSenha(boolean alterarSenha) {
		this.alterarSenha = alterarSenha;
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	public String getTelefone() {
		return telefone;
	}

	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}

	public String getRamal() {
		return ramal;
	}

	public void setRamal(String ramal) {
		this.ramal = ramal;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return this.roles;
	}

	@Override
	public String getPassword() {
		return this.senha;
	}

	@Override
	public String getUsername() {
		return this.email;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}

	public Setor getSetor() {
		return setor;
	}

	public void setSetor(Setor setor) {
		this.setor = setor;
	}

	public void passwordEncoder() {
		this.senha = new BCryptPasswordEncoder().encode(this.senha);
	}

	public List<Chamado> getChamados() {
		return chamados;
	}

	public void setChamados(List<Chamado> chamados) {
		this.chamados = chamados;
	}

	public void atualizaDados(Usuario usuarioAlt) {
		this.email = usuarioAlt.getEmail();
		this.senha = usuarioAlt.getSenha();
		this.nome = usuarioAlt.getNome().replace("-", "");
		this.telefone = usuarioAlt.getTelefone();
		this.ramal = usuarioAlt.getRamal();
		this.alterarSenha = usuarioAlt.isAlterarSenha();
		passwordEncoder();
	}

	public boolean validaSenha() {
		if (this.senha.isEmpty() || this.senha == null)
			return false;
		if (this.senha.length() < 6)
			return false;
		return true;
	}
	
	public String getPerfil() {
		String perfis = "";
		for (Role role : roles) {
			perfis += role.getLabel() + ",";
		}
		return perfis.substring(0, perfis.length()-1);
	}
	
	public String getOperadorPerfil() {
		String perfis = "";
		for (Role role : roles) {
			if(!role.getNome().equals("ROLE_USER"))
				perfis += role.getLabel() + ",";
		}
		return perfis.substring(0, perfis.length()-1);
	}

	/**
	 * Alimenta lista de perfis de acordo com a lista roles
	 * */
	public void preparaPerfilList() {
		for(Role r: this.getRoles()) {
			this.getPerfis().add(r.getLabel());
		}
	}
	
	public boolean contemPerfil(String prfl) {
		boolean contemPerfil = false;
		
		for(String perfil : this.perfis) {
			if(perfil.equals(prfl)) 
				contemPerfil = true;
		}
		return contemPerfil;				
	}
	
	public boolean isOperador() {
		boolean operador = false;
		for (Role role : this.roles) {
			if(role.getNome().equals("ROLE_ADMIN")) {
				operador = true;
			} else if(role.getNome().equals("ROLE_SUP")) {
				operador = true;
			}
		}
		return operador;
	}
}
