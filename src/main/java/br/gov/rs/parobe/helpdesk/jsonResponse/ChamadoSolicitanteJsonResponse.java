package br.gov.rs.parobe.helpdesk.jsonResponse;

import java.util.Map;

import br.gov.rs.parobe.helpdesk.model.Chamado;

public class ChamadoSolicitanteJsonResponse {

	private Chamado chamado;
	private boolean validated;
	private Map<String, String> errorMessages;
	private String message;
	private String descricaoChamado;

	public ChamadoSolicitanteJsonResponse() {
	}

	public ChamadoSolicitanteJsonResponse(Chamado chamado, boolean validated, Map<String, String> errorMessages, String message) {
		this.chamado = chamado;
		this.validated = validated;
		this.errorMessages = errorMessages;
		this.message = message;
	}

	public Chamado getChamado() {
		return chamado;
	}

	public void setChamado(Chamado chamado) {
		this.chamado = chamado;
	}

	public boolean isValidated() {
		return validated;
	}

	public void setValidated(boolean validated) {
		this.validated = validated;
	}

	public Map<String, String> getErrorMessages() {
		return errorMessages;
	}

	public void setErrorMessages(Map<String, String> errorMessages) {
		this.errorMessages = errorMessages;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getDescricaoChamado() {
		return descricaoChamado;
	}

	public void setDescricaoChamado(String descricaoChamado) {
		this.descricaoChamado = descricaoChamado;
	}

}
