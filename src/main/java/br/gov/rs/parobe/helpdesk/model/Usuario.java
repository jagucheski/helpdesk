package br.gov.rs.parobe.helpdesk.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@Entity
public class Usuario implements UserDetails {
	
	private static final long serialVersionUID = 1L;

	@Id 
	@NotNull(message="O Campo email é obrigatório")
	@Length(max = 255)
	@Email(regexp = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$", message="Email informado é inválido")
	private String email;

	@NotNull(message="O Campo senha é obrigatório")
	@Length(min = 6, max = 30, message = "A senha deve conter no mínimo 6 caracteres")
	private String senha;

	@NotNull(message="O Campo nome é obrigatório")
	@Length(min = 6, max = 50, message = "O nome deve conter no mínimo 6 caracteres")
	private String nome;
	
	@Length(max = 30, message = "O número de caracteres excede o permitido")
	private String telefone;

	@Length(max = 20, message = "O número de caracteres excede o permitido")
	private String ramal;
	
	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.PERSIST)
	private List<Role> roles = new ArrayList<>();

	public Usuario() {
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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
}
