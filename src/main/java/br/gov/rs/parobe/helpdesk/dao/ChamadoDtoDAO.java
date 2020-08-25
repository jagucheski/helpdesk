package br.gov.rs.parobe.helpdesk.dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import br.gov.rs.parobe.helpdesk.dto.ChamadoEstatisticoDto;
import br.gov.rs.parobe.helpdesk.dto.ChamadoMesStatusDto;
import br.gov.rs.parobe.helpdesk.model.Usuario;

@Repository
public class ChamadoDtoDAO {

	@PersistenceContext
	private EntityManager manager;

	/**
	 * Metodo responsável por carregar dados estatísticos de chamados realizados conforme filtros informados 
	 * */
	@SuppressWarnings("unchecked")
	public List<ChamadoEstatisticoDto> findChamadosEstatisticoByYear(ChamadoEstatisticoDto chamadoDtoFind) {
		List<ChamadoEstatisticoDto> chamados = new ArrayList<ChamadoEstatisticoDto>();
		try {
			chamados = manager.createQuery(preparaQueryEstatistico(chamadoDtoFind)).getResultList();
		} catch (Exception e) {
			System.out.println(e);
		}
		return chamados;
	}
	
	/**
	 * Metodo responsável por carregar somatorio de chamados por status e mes do ano corrente para apresentação de grafico 
	 * */
	@SuppressWarnings("unchecked")
	public 	List<ChamadoMesStatusDto> getChamadosCharBarDto(Usuario usuario, String ano, String mesCorrente) {
		return manager.createQuery(preparaQueryChartBar(usuario, ano, mesCorrente)).getResultList();
	}

	/**
	 * Metodo responsável por preparar query dos dados estatísticos de chamados realizados 
	 * */
	private String preparaQueryEstatistico(ChamadoEstatisticoDto chamadoDtoFind) {
		String query = "select new br.gov.rs.parobe.helpdesk.dto.ChamadoEstatisticoDto(setor.nome,c.solicitante.email,c.status,count(c.id), to_char(c.dataAbertura,'YYYY'),to_char(c.dataAbertura,'MM')) "
				+ "from Chamado c left join c.setor as setor where 1=1";

		if (chamadoDtoFind.getAnoCriacao() != null && !chamadoDtoFind.getAnoCriacao().isEmpty())
			query += " and TO_DATE(to_char(c.dataAbertura,'YYYY'),'YYYY') = to_timestamp('"
					+ chamadoDtoFind.getAnoCriacao() + "', 'YYYY')";

		if (chamadoDtoFind.getMesCriacao() != null && !chamadoDtoFind.getMesCriacao().isEmpty())
			query += " and TO_DATE(to_char(c.dataAbertura,'MM'),'MM') = to_timestamp('" + chamadoDtoFind.getMesCriacao()
					+ "', 'MM')";

		if (chamadoDtoFind.getSetor() != null && !chamadoDtoFind.getSetor().isEmpty())
			query += " and setor.nome='" + chamadoDtoFind.getSetor() + "'";

		if (chamadoDtoFind.getStatus() != null && !chamadoDtoFind.getStatus().isEmpty())
			query += " and c.status='" + chamadoDtoFind.getStatus() + "'";

		query += " group by setor.nome, c.solicitante.email, c.status, to_char(c.dataAbertura,'YYYY'), to_char(c.dataAbertura,'MM') "
				+ " order by  to_char(c.dataAbertura,'YYYY'), to_char(c.dataAbertura,'MM'), setor.nome, c.solicitante.email, c.status ";

		return query;
	}

	/**
	 * Metodo responsável por preparar query do somatorio de chamados por status e mes do ano corrente para apresentação de grafico 
	 * */
	private String preparaQueryChartBar(Usuario usuario, String ano, String mes) {
		String query = " select new br.gov.rs.parobe.helpdesk.dto.ChamadoMesStatusDto(c.status,count(c.id)) "
				+ " from Chamado c " 
				+ " where TO_DATE(to_char(c.dataAbertura,'YYYY'),'YYYY') = to_timestamp('"+ ano+"', 'YYYY')"
				+ " and TO_DATE(to_char(c.dataAbertura,'MM'),'MM') = to_timestamp('"+ mes+"', 'MM')";

		if (!usuario.isOperador())
			query += " and c.solicitante.email = '" + usuario.getEmail() + "' ";

		query +=  " group by c.status "
				+ " order by c.status";
		return query;
	}

}
