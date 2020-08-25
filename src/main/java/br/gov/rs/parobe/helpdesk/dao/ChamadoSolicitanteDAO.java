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
import br.gov.rs.parobe.helpdesk.model.Usuario;

@Repository
public class ChamadoSolicitanteDAO {

	@PersistenceContext
	private EntityManager manager;

	public List<Chamado> getChamadosSolicitante(Usuario solicintante) {
		return manager.createQuery("from Chamado c where c.solicitante.email=:solicitanteEmail order by c.dataAbertura desc", Chamado.class)
				.setParameter("solicitanteEmail", solicintante.getEmail())
				.getResultList();
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
	
	public List<Chamado> findChamadoSolicitante(Usuario solicitante, String status, String dataAbertura, String descricao) throws ParseException {
		CriteriaBuilder criteriaBuilder = manager.getCriteriaBuilder();
		CriteriaQuery<Chamado> query = criteriaBuilder.createQuery(Chamado.class);
		Root<Chamado> root = query.from(Chamado.class);
		
		Path<String> statusPath = root.<String> get("status");
		Path<String> descricaoPath = root.<String> get("descricao");
		Path<String> solicitantePath = root.<String> get("solicitante").get("email");
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

		Predicate solicitanteIgual = criteriaBuilder.like(criteriaBuilder.lower(solicitantePath), solicitante.getEmail().toLowerCase());
		predicates.add(solicitanteIgual);
	
		query.where((Predicate[]) predicates.toArray(new Predicate[0]));
		TypedQuery<Chamado> typedQuery = manager.createQuery(query.orderBy(criteriaBuilder.desc(root.get("dataAbertura"))));

		return typedQuery.getResultList();
	}

	public Chamado getByChamado(Chamado chamado) {
		return manager.createQuery("select c from Chamado c where c.id=:id AND c.solicitante.email=:email", Chamado.class)
				.setParameter("id", chamado.getId())
				.setParameter("email", chamado.getSolicitante().getEmail()).getSingleResult();	
	}
	
	public Chamado getByIdEmail(int id, String email) {
		return manager.createQuery("select c from Chamado c where c.id=:id AND c.solicitante.email=:email", Chamado.class)
				.setParameter("id", id)
				.setParameter("email", email).getSingleResult();	
	}
	
}