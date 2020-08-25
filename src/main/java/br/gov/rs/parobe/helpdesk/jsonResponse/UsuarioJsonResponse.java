package br.gov.rs.parobe.helpdesk.jsonResponse;

import java.util.Map;

import br.gov.rs.parobe.helpdesk.model.Usuario;

public class UsuarioJsonResponse {

	private Usuario usuario;
	private boolean validated;
	private Map<String, String> errorMessages;
	private String message;

	public UsuarioJsonResponse() {
	}

	public UsuarioJsonResponse(Usuario usuario, boolean validated, Map<String, String> errorMessages, String message) {
		this.usuario = usuario;
		this.validated = validated;
		this.errorMessages = errorMessages;
		this.message = message;
	}

	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
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
