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

import org.springframework.stereotype.Repository;

import br.gov.rs.parobe.helpdesk.model.Categoria;

@Repository
public class CategoriaDAO {

	@PersistenceContext
	private EntityManager manager;

	public List<Categoria> getCategorias() {
		return manager.createQuery("select distinct c from Categoria c left join fetch c.subCategorias", Categoria.class).getResultList();
	}
	
	public Categoria getOne(Categoria categoria) {
		return manager.createQuery("from Categoria c where c.id = :id", Categoria.class).setParameter("id", categoria.getId()).getSingleResult() ;
	}
	
	public Categoria getById(int id) {
		return manager.createQuery("from Categoria c where c.id = :id", Categoria.class).setParameter("id", id).getSingleResult() ;
	}
	
	public Categoria getByNome(String nome) {
		return manager.createQuery("from Categoria c where c.nome = :nome", Categoria.class).setParameter("nome", nome).getSingleResult() ;
	}
	
	public List<Categoria> findByCategoria(String nome) {
		CriteriaBuilder criteriaBuilder = manager.getCriteriaBuilder();
		CriteriaQuery<Categoria> query = criteriaBuilder.createQuery(Categoria.class);
		Root<Categoria> root = query.from(Categoria.class);
		query.distinct(true);
		root.fetch("subCategorias", JoinType.LEFT);
				
		Path<String> nomePath = root.<String> get("nome");		
		List<Predicate> predicates = new ArrayList<Predicate>();
		
		if (!nome.isEmpty()) {
			Predicate nomeIgual = criteriaBuilder.like(criteriaBuilder.lower(nomePath), "%" + nome.toLowerCase() + "%");
			predicates.add(nomeIgual);
		}

		query.where((Predicate[]) predicates.toArray(new Predicate[0]));
		TypedQuery<Categoria> typedQuery = manager.createQuery(query);
		return typedQuery.getResultList();
	}
	
	public boolean existCategoriaByNome(String nome) {
		return manager.createQuery("select c from Categoria c where c.nome = :nome", Categoria.class).setParameter("nome", nome).getResultList().isEmpty() == true ? false : true;
     }
	
	public void gravar(Categoria categoria) {
		manager.persist(categoria);
	}

	public void deletar(Categoria categoria) {
		manager.remove(categoria);
	}
}
