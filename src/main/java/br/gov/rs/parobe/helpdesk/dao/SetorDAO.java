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

import org.springframework.stereotype.Repository;

import br.gov.rs.parobe.helpdesk.model.Setor;

@Repository
public class SetorDAO {

	@PersistenceContext
	private EntityManager manager;

	public List<Setor> getSetores() {
		return manager.createQuery("select s from Setor s ", Setor.class).getResultList();
	}

	public void gravar(Setor setor) {
		manager.persist(setor);
	}

	public void deletar(Setor setor) {
		manager.remove(setor);
	}

	public Setor getByNome(String nomeSetor) {
		return manager.createQuery("select s from Setor s where s.nome = :nome", Setor.class).setParameter("nome",nomeSetor).getSingleResult();		
	}
	
	public Setor getByNomeId(Setor s) {
		return manager.createQuery("select s from Setor s where s.nome = :nome And s.id = :id", Setor.class)
				.setParameter("nome", s.getNome())
				.setParameter("id", s.getId()).getSingleResult();		
	}
	
	public Setor getById(int id) {
		return manager.createQuery("select s from Setor s where s.id = :id", Setor.class)
				.setParameter("id",id).getSingleResult();		
	}
	
	public List<Setor> findBySetor(String nome, String descricao) {
		CriteriaBuilder criteriaBuilder = manager.getCriteriaBuilder();
		CriteriaQuery<Setor> query = criteriaBuilder.createQuery(Setor.class);
		Root<Setor> root = query.from(Setor.class);
		
		Path<String> nomePath = root.<String> get("nome");
		Path<String> descricaoPath = root.<String> get("descricao");
		
		List<Predicate> predicates = new ArrayList<Predicate>();

		if (!nome.isEmpty()) {
			Predicate nomeIgual = criteriaBuilder.like(criteriaBuilder.lower(nomePath), "%" + nome.toLowerCase() + "%");
			predicates.add(nomeIgual);
		}
		
		if (!descricao.isEmpty()) {
			Predicate descricaoIgual = criteriaBuilder.like(criteriaBuilder.lower(descricaoPath), "%" + descricao.toLowerCase() + "%");
			predicates.add(descricaoIgual);
		}

		query.where((Predicate[]) predicates.toArray(new Predicate[0]));

		TypedQuery<Setor> typedQuery = manager.createQuery(query);
		typedQuery.setHint("org.hibernate.cacheable", "true");

		return typedQuery.getResultList();
	}
	
	public boolean existSetorByNome(String nome) {
		return manager.createQuery("select s from Setor s where nome = :nome", Setor.class).setParameter("nome", nome).getResultList().isEmpty() == true ? false : true;
     }

	public Setor getOne(Setor setor) {
		return manager.createQuery("select s from Setor s where s.id = :id", Setor.class).setParameter("id", setor.getId()).getSingleResult() ;
	}

}
