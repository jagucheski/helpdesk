package br.gov.rs.parobe.helpdesk.dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.JoinType;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Repository;

import br.gov.rs.parobe.helpdesk.model.Usuario;

@Repository
public class SolicitanteDAO{

	@PersistenceContext
	private EntityManager manager;

	public List<Usuario> getSolicitantes() {
		List<Usuario> solicitantesBase = manager.createQuery("select distinct u from Usuario u join fetch u.roles", Usuario.class).getResultList();
		List<Usuario> solicitantes = new ArrayList <Usuario> ();
		
		if (solicitantesBase != null) {
			for (Usuario usuario: solicitantesBase) {
				if(!usuario.isOperador())
					solicitantes.add(usuario);
			}
		}
		return solicitantes;		
	}
	
	public Usuario getByEmail(String email) {
		Usuario solicitante = manager.createQuery("select distinct u from Usuario u join fetch u.roles where u.email LIKE :email", Usuario.class)
				.setParameter("email", email + "%").getSingleResult();

		if (solicitante == null) {
			throw new UsernameNotFoundException("Solicitante " + email + " não foi encontrado");
		}
		return solicitante;
	}

	public boolean existUserName(String email) {
		return manager.createQuery("select u from Usuario u where email = :email", Usuario.class).setParameter("email", email).getResultList().isEmpty() == true ? false : true;
     }

	public void gravar(Usuario solicitante) {
		manager.persist(solicitante);
	}

	public void deletar(Usuario solicitante) {
		manager.remove(solicitante);
	}
	
	public List<Usuario> findBySolicitante(String nome, String email) {
		CriteriaBuilder criteriaBuilder = manager.getCriteriaBuilder();
		CriteriaQuery<Usuario> query = criteriaBuilder.createQuery(Usuario.class);
		Root<Usuario> root = query.from(Usuario.class);
		query.distinct(true);
		root.fetch("roles", JoinType.LEFT);
		
		Path<String> nomePath = root.<String> get("nome");
		Path<String> emailPath = root.<String> get("email");
		
		List<Predicate> predicates = new ArrayList<Predicate>();

		if (!nome.isEmpty()) {
			Predicate nomeIgual = criteriaBuilder.like(criteriaBuilder.lower(nomePath), "%" + nome.toLowerCase() + "%");
			predicates.add(nomeIgual);
		}
		
		if (!email.isEmpty()) {
			Predicate emailIgual = criteriaBuilder.like(criteriaBuilder.lower(emailPath), "%" + email.toLowerCase() + "%");
			predicates.add(emailIgual);
		}

		query.where((Predicate[]) predicates.toArray(new Predicate[0]));
		TypedQuery<Usuario> typedQuery = manager.createQuery(query);
		
		List<Usuario> solicitantesBase = typedQuery.getResultList();
		List<Usuario> solicitantes = new ArrayList <Usuario> ();

		if (solicitantesBase != null) {
			for (Usuario usuario: solicitantesBase) {
				if(!usuario.isOperador())
					solicitantes.add(usuario);
			}
		}
		return solicitantes;
	}
	
	public Usuario loadUserByUsername(String email) {
		List<Usuario> solicitantes = manager.createQuery("select distinct u from Usuario u join fetch u.roles where email = :email", Usuario.class)
				.setParameter("email", email).getResultList();
		if (solicitantes.isEmpty()) {
			throw new UsernameNotFoundException("Solicitante " + email + " não foi encontrado");
		}
		return solicitantes.get(0);
	}
}