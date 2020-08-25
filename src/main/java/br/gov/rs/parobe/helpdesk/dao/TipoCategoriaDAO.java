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

import br.gov.rs.parobe.helpdesk.model.TipoCategoria;

@Repository
public class TipoCategoriaDAO {

	@PersistenceContext
	private EntityManager manager;

	public List<TipoCategoria> getTipoCategorias() {
		return manager.createQuery("from TipoCategoria", TipoCategoria.class).getResultList();
	}
	
	public TipoCategoria getOne(TipoCategoria tipoCategoria) {
		return manager.createQuery("from TipoCategoria tc where tc.id = :id", TipoCategoria.class).setParameter("id", tipoCategoria.getId()).getSingleResult() ;
	}

	public TipoCategoria getByNome(String nome) {
		return manager.createQuery("from TipoCategoria tc where tc.nome = :nome", TipoCategoria.class).setParameter("nome", nome).getSingleResult() ;
	}
	
	public List<TipoCategoria> findByTipoCategoria(String nome, String descricao) {
		CriteriaBuilder criteriaBuilder = manager.getCriteriaBuilder();
		CriteriaQuery<TipoCategoria> query = criteriaBuilder.createQuery(TipoCategoria.class);
		Root<TipoCategoria> root = query.from(TipoCategoria.class);
		
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
		TypedQuery<TipoCategoria> typedQuery = manager.createQuery(query);
		return typedQuery.getResultList();
	}
	
	public boolean existTipoCategoriaByNome(String nome) {
		return manager.createQuery("select tc from TipoCategoria tc where tc.nome = :nome", TipoCategoria.class).setParameter("nome", nome).getResultList().isEmpty() == true ? false : true;
     }
	
	public void gravar(TipoCategoria tipoCategoria) {
		manager.persist(tipoCategoria);
	}

	public void deletar(TipoCategoria tipoCategoria) {
		manager.remove(tipoCategoria);
	}
}
