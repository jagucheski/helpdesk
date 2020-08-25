package br.gov.rs.parobe.helpdesk.dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Repository;

import br.gov.rs.parobe.helpdesk.model.Role;

@Repository
public class RoleDAO {

	@PersistenceContext
	private EntityManager manager;

	public List<Role> getRoles() {
		return manager.createQuery("from Role", Role.class).getResultList();
	}

	public List<String> getLabels() {
		List<Role> roles = manager.createQuery("from Role", Role.class).getResultList();

		if (roles == null)
			return null;

		List<String> labellist = new ArrayList<String>();
		for (Role r : roles) {
			labellist.add(r.getLabel());
		}
		return labellist;
	}

	public Role getByNome(String nome) {
		Role role = manager.createQuery("from Role where nome = :nome", Role.class).setParameter("nome", nome)
				.getSingleResult();
		if (role == null) {
			throw new UsernameNotFoundException("Role " + nome + " não foi encontrado");
		}
		return role;
	}

	public Role getByLabel(String label) {
		Role role = manager.createQuery("from Role where label LIKE :label", Role.class)
				.setParameter("label", label + "%").getSingleResult();
		if (role == null) {
			throw new UsernameNotFoundException("Role " + label + " não foi encontrado");
		}
		return role;
	}

	public void gravar(Role role) {
		manager.persist(role);
	}

	public void deletar(Role role) {
		manager.remove(role);
	}

}