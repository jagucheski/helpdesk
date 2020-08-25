package br.gov.rs.parobe.helpdesk.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import br.gov.rs.parobe.helpdesk.model.Chamado;
import br.gov.rs.parobe.helpdesk.model.Mensagem;


@Repository
public class MensagemDAO {

	@PersistenceContext
	private EntityManager manager;
	
	public List<Mensagem> getMensagensChamados(Chamado chamado) {
		return manager.createQuery("from Mensagem m where m.chamado.id=:chamadoId order by m.data desc", Mensagem.class)
				.setParameter("chamadoId", chamado.getId())
				.getResultList();
	}

	public void gravar(Mensagem mensagem) {
		manager.persist(mensagem);
	}

	public void deletar(Mensagem mensagem) {
		manager.remove(mensagem);
	}

	public Mensagem getOne(int id) {
		return manager.createQuery("select m from Mensagem m where m.id = :id", Mensagem.class)
				.setParameter("id",id).getSingleResult();		
	}
}
