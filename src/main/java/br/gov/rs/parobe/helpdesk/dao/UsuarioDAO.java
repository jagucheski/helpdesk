package br.gov.rs.parobe.helpdesk.dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Join;
import javax.persistence.criteria.JoinType;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Repository;

import br.gov.rs.parobe.helpdesk.model.Role;
import br.gov.rs.parobe.helpdesk.model.Usuario;

@Repository
public class UsuarioDAO implements UserDetailsService {

	@PersistenceContext
	private EntityManager manager;

	public List<Usuario> getUsuarios() {
		return manager.createQuery("select distinct u from Usuario u join fetch u.roles", Usuario.class).getResultList();
	}
	
	public Usuario loadUserByUsername(String email) {
		List<Usuario> usuarios = manager.createQuery("select distinct u from Usuario u join fetch u.roles where email = :email", Usuario.class)
				.setParameter("email", email).getResultList();
		if (usuarios.isEmpty()) {
			throw new UsernameNotFoundException("Usuário " + email + " não foi encontrado");
		}
		return usuarios.get(0);
	}
	
	public Usuario getByEmail(String email) {
		Usuario usuario = manager.createQuery("select distinct u from Usuario u join fetch u.roles where u.email LIKE :email", Usuario.class)
				.setParameter("email", email + "%").getSingleResult();

		if (usuario == null) {
			throw new UsernameNotFoundException("Usuário " + email + " não foi encontrado");
		}
		return usuario;
	}

	public boolean existUserName(String email) {
		return manager.createQuery("select u from Usuario u where email = :email", Usuario.class).setParameter("email", email).getResultList().isEmpty() == true ? false : true;
     }

	public void gravar(Usuario usuario) {
		manager.persist(usuario);
	}

	public void deletar(Usuario usuario) {
		manager.remove(usuario);
	}
	
	public List<Usuario> findByUsuario(String nome, String email, String perfil ) {
		CriteriaBuilder criteriaBuilder = manager.getCriteriaBuilder();
		CriteriaQuery<Usuario> query = criteriaBuilder.createQuery(Usuario.class);
		Root<Usuario> root = query.from(Usuario.class);
		query.distinct(true);
		root.fetch("roles", JoinType.LEFT);
		
		Join<Usuario, Role> join = root.join("roles");
		
		Path<String> nomePath = root.<String> get("nome");
		Path<String> emailPath = root.<String> get("email");
		Path<String> campoRoleId = join.get("nome");
		
		List<Predicate> predicates = new ArrayList<Predicate>();

		if (!nome.isEmpty()) {
			Predicate nomeIgual = criteriaBuilder.like(criteriaBuilder.lower(nomePath), "%" + nome.toLowerCase() + "%");
			predicates.add(nomeIgual);
		}
		
		if (!email.isEmpty()) {
			Predicate emailIgual = criteriaBuilder.like(criteriaBuilder.lower(emailPath), "%" + email.toLowerCase() + "%");
			predicates.add(emailIgual);
		}

		if (!perfil.isEmpty()) {
			Predicate perfilIgual = criteriaBuilder.isTrue(campoRoleId.in(perfil));
			predicates.add(perfilIgual);
		}

		query.where((Predicate[]) predicates.toArray(new Predicate[0]));

		TypedQuery<Usuario> typedQuery = manager.createQuery(query);
		typedQuery.setHint("org.hibernate.cacheable", "true");

		return typedQuery.getResultList();
		
	}

}