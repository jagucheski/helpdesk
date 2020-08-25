package br.gov.rs.parobe.helpdesk.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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

import br.gov.rs.parobe.helpdesk.model.Chamado;

@Repository
public class ChamadoDAO {

	@PersistenceContext
	private EntityManager manager;

	public List<Chamado> getChamados() {
		return manager.createQuery("from Chamado c order by c.dataAbertura desc", Chamado.class).setMaxResults(100).getResultList();
	}

	public void gravar(Chamado chamado) {
		manager.persist(chamado);
	}

	public void deletar(Chamado chamado) {
		manager.remove(chamado);
	}

	public Chamado getOne(int id) {
		return manager.createQuery("select c from Chamado c where c.id = :id", Chamado.class)
				.setParameter("id",id).getSingleResult();		
	}
	
	public List<Chamado> findChamado(String status, String dataAbertura, String descricao) throws ParseException {
		CriteriaBuilder criteriaBuilder = manager.getCriteriaBuilder();
		CriteriaQuery<Chamado> query = criteriaBuilder.createQuery(Chamado.class);
		Root<Chamado> root = query.from(Chamado.class);
		
		Path<String> statusPath = root.<String> get("status");
		Path<String> descricaoPath = root.<String> get("descricao");
		List<Predicate> predicates = new ArrayList<Predicate>();
		
		if (!status.isEmpty()) {
			Predicate statusIgual = criteriaBuilder.like(criteriaBuilder.lower(statusPath), status.toLowerCase());
			predicates.add(statusIgual);
		}

		if (!dataAbertura.isEmpty()) {
			Date dataAberturaFind = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(dataAbertura + " 23:59");
			predicates.add(criteriaBuilder.lessThan(root.get("dataAbertura"), dataAberturaFind));
		}

		if (!descricao.isEmpty()) {
			Predicate descricaoIgual = criteriaBuilder.like(criteriaBuilder.lower(descricaoPath), "%" + descricao.toLowerCase() + "%");
			predicates.add(descricaoIgual);
		}
	
		query.where((Predicate[]) predicates.toArray(new Predicate[0]));
		TypedQuery<Chamado> typedQuery = manager.createQuery(query.orderBy(criteriaBuilder.desc(root.get("dataAbertura")))).setMaxResults(100);

		return typedQuery.getResultList();
	}
	
	public List<Chamado> findChamadoOperador(String status, Integer anoAbertura, String descricao) throws ParseException {
		CriteriaBuilder criteriaBuilder = manager.getCriteriaBuilder();
		CriteriaQuery<Chamado> query = criteriaBuilder.createQuery(Chamado.class);
		Root<Chamado> root = query.from(Chamado.class);
		
		Path<String> statusPath = root.<String> get("status");
		Path<String> descricaoPath = root.<String> get("descricao");
		List<Predicate> predicates = new ArrayList<Predicate>();
		
		if (!status.isEmpty()) {
			Predicate statusIgual = criteriaBuilder.like(criteriaBuilder.lower(statusPath), status.toLowerCase());
			predicates.add(statusIgual);
		}

		if (anoAbertura!=null) {
			predicates.add(criteriaBuilder.equal(criteriaBuilder.function("year", Integer.class, root.get("dataAbertura")), anoAbertura));
		}

		if (!descricao.isEmpty()) {
			Predicate descricaoIgual = criteriaBuilder.like(criteriaBuilder.lower(descricaoPath), "%" + descricao.toLowerCase() + "%");
			predicates.add(descricaoIgual);
		}
	
		query.where((Predicate[]) predicates.toArray(new Predicate[0]));
		TypedQuery<Chamado> typedQuery = manager.createQuery(query.orderBy(criteriaBuilder.desc(root.get("dataAbertura")))).setMaxResults(100);

		return typedQuery.getResultList();
	}
	
}