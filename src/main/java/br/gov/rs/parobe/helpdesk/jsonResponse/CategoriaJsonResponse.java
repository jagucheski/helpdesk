package br.gov.rs.parobe.helpdesk.jsonResponse;

import java.util.Map;

import br.gov.rs.parobe.helpdesk.model.Categoria;

public class CategoriaJsonResponse {

	private Categoria categoria;
	private boolean validated;
	private Map<String, String> errorMessages;
	private String message;

	public CategoriaJsonResponse() {
	}

	public CategoriaJsonResponse(Categoria categoria, boolean validated, Map<String, String> errorMessages, String message) {
		this.categoria = categoria;
		this.validated = validated;
		this.errorMessages = errorMessages;
		this.message = message;
	}

	public Categoria getCategoria() {
		return categoria;
	}

	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
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
