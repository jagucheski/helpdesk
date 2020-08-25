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

import br.gov.rs.parobe.helpdesk.model.SubCategoria;

@Repository
public class SubCategoriaDAO {

	@PersistenceContext
	private EntityManager manager;

	public List<SubCategoria> getSubCategorias() {
		return manager.createQuery("from SubCategoria sc order by sc.id", SubCategoria.class).getResultList();
	}
	
	public SubCategoria getOne(SubCategoria subCategoria) {
		return manager.createQuery("from SubCategoria sc where sc.id = :id", SubCategoria.class).setParameter("id", subCategoria.getId()).getSingleResult() ;
	}

	public SubCategoria getByNome(String nome) {
		return manager.createQuery("from SubCategoria sc where sc.nome = :nome", SubCategoria.class).setParameter("nome", nome).getSingleResult() ;
	}
	
	public List<SubCategoria> findBySubCategoria(String nome) {
		CriteriaBuilder criteriaBuilder = manager.getCriteriaBuilder();
		CriteriaQuery<SubCategoria> query = criteriaBuilder.createQuery(SubCategoria.class);
		Root<SubCategoria> root = query.from(SubCategoria.class);
		
		Path<String> nomePath = root.<String> get("nome");		
		List<Predicate> predicates = new ArrayList<Predicate>();
		
		if (!nome.isEmpty()) {
			Predicate nomeIgual = criteriaBuilder.like(criteriaBuilder.lower(nomePath), "%" + nome.toLowerCase() + "%");
			predicates.add(nomeIgual);
		}

		query.where((Predicate[]) predicates.toArray(new Predicate[0]));
		TypedQuery<SubCategoria> typedQuery = manager.createQuery(query);
		return typedQuery.getResultList();
	}
	
	public boolean existSubCategoriaByNome(String nome) {
		return manager.createQuery("select sc from SubCategoria sc where sc.nome = :nome", SubCategoria.class).setParameter("nome", nome).getResultList().isEmpty() == true ? false : true;
     }
	
	public void gravar(SubCategoria subCategoria) {
		manager.persist(subCategoria);
	}

	public void deletar(SubCategoria subCategoria) {
		manager.remove(subCategoria);
	}
}
