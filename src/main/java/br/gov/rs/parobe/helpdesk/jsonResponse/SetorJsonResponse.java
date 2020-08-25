package br.gov.rs.parobe.helpdesk.jsonResponse;

import java.util.Map;

import br.gov.rs.parobe.helpdesk.model.Setor;

public class SetorJsonResponse {

	private Setor setor;
	private boolean validated;
	private Map<String, String> errorMessages;
	private String message;

	public SetorJsonResponse() {
	}

	public SetorJsonResponse(Setor setor, boolean validated, Map<String, String> errorMessages, String message) {
		this.setor = setor;
		this.validated = validated;
		this.errorMessages = errorMessages;
		this.message = message;
	}

	public Setor getSetor() {
		return setor;
	}

	public void setSetor(Setor setor) {
		this.setor = setor;
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

}
