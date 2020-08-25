package br.gov.rs.parobe.helpdesk.dto;

public class ChamadoEstatisticoDto {

	private String setor;
	private String solicitante;
	private String status;
	private Long qtde;
	private String anoCriacao;
	private String mesCriacao;
	
	public ChamadoEstatisticoDto() {
	}

	public ChamadoEstatisticoDto(String setor, String solicitante, String status, Long qtde, String anoCriacao, String mesCriacao) {
		this.setor = setor;
		this.solicitante = solicitante;
		this.status = status;
		this.qtde = qtde;
		this.anoCriacao = anoCriacao;
		this.mesCriacao = mesCriacao;
	}

	public String getSetor() {
		return setor;
	}

	public void setSetor(String setor) {
		this.setor = setor;
	}

	public String getSolicitante() {
		return solicitante;
	}

	public void setSolicitante(String solicitante) {
		this.solicitante = solicitante;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Long getQtde() {
		return qtde;
	}

	public void setQtde(Long qtde) {
		this.qtde = qtde;
	}

	public String getAnoCriacao() {
		return anoCriacao;
	}

	public void setAnoCriacao(String anoCriacao) {
		this.anoCriacao = anoCriacao;
	}

	public String getMesCriacao() {
		return mesCriacao;
	}

	public void setMesCriacao(String mesCriacao) {
		this.mesCriacao = mesCriacao;
	}
	
	public String getMesCriacaoDesc() {
		String retorno = "";

		if (this.mesCriacao.equals("01"))
			retorno = "Janeiro";
		else if (this.mesCriacao.equals("02"))
			retorno = "Fevereiro";
		else if (this.mesCriacao.equals("03"))
			retorno = "Março";
		else if (this.mesCriacao.equals("04"))
			retorno = "Abril";
		else if (this.mesCriacao.equals("05"))
			retorno = "Maio";
		else if (this.mesCriacao.equals("06"))
			retorno = "Junho";
		else if (this.mesCriacao.equals("07"))
			retorno = "Julho";
		else if (this.mesCriacao.equals("08"))
			retorno = "Agosto";
		else if (this.mesCriacao.equals("09"))
			retorno = "Setembro";
		else if (this.mesCriacao.equals("10"))
			retorno = "Outubro";
		else if (this.mesCriacao.equals("11"))
			retorno = "Novembro";
		else if (this.mesCriacao.equals("12"))
			retorno = "Dezembro";

		return retorno;
	}

	
}
