package br.gov.rs.parobe.helpdesk.dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Repository;

import br.gov.rs.parobe.helpdesk.model.Usuario;

@Repository
public class UsuarioDAO implements UserDetailsService {

	@PersistenceContext
	private EntityManager manager;

	public List<Usuario> getUsuarios() {
		return manager.createQuery("from Usuario", Usuario.class).getResultList();
	}
	
	public Usuario loadUserByUsername(String email) {
		List<Usuario> usuarios = manager.createQuery("select u from Usuario u where email = :email", Usuario.class)
				.setParameter("email", email).getResultList();
		if (usuarios.isEmpty()) {
			throw new UsernameNotFoundException("Usuário " + email + " não foi encontrado");
		}
		return usuarios.get(0);
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
	
	//TODO inner featch para trazer roles no mesmo select
	public List<Usuario> findByUsuario(String nome, String email, String perfil ) {
		CriteriaBuilder criteriaBuilder = manager.getCriteriaBuilder();
		CriteriaQuery<Usuario> query = criteriaBuilder.createQuery(Usuario.class);
		Root<Usuario> root = query.from(Usuario.class);

		Path<String> nomePath = root.<String> get("nome");
		Path<String> emailPath = root.<String> get("email");
//		Path<String> perfilPath = root.<String> get("perfil");
		

		List<Predicate> predicates = new ArrayList<Predicate>();

		if (!nome.isEmpty()) {
			Predicate nomeIgual = criteriaBuilder.like(criteriaBuilder.lower(nomePath), "%" + nome.toLowerCase() + "%");
			predicates.add(nomeIgual);
		}
		
		if (!email.isEmpty()) {
			Predicate emailIgual = criteriaBuilder.like(criteriaBuilder.lower(emailPath), "%" + email.toLowerCase() + "%");
			predicates.add(emailIgual);
		}

//		if (!perfil.isEmpty()) {
//			Predicate perfilIgual = criteriaBuilder.like(criteriaBuilder.lower(perfilPath), "%" + perfil.toLowerCase() + "%");
//			predicates.add(perfilIgual);
//		}

		query.where((Predicate[]) predicates.toArray(new Predicate[0]));

		TypedQuery<Usuario> typedQuery = manager.createQuery(query);
		typedQuery.setHint("org.hibernate.cacheable", "true");

		return typedQuery.getResultList();
		
		
	}

}