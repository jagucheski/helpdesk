package br.gov.rs.parobe.helpdesk.jsonResponse;

import java.util.Map;

import br.gov.rs.parobe.helpdesk.model.TipoCategoria;

public class TipoCategoriaJsonResponse {

	private TipoCategoria tipoCategoria;
	private boolean validated;
	private Map<String, String> errorMessages;
	private String message;

	public TipoCategoriaJsonResponse() {
	}

	public TipoCategoriaJsonResponse(TipoCategoria tipoCategoria, boolean validated, Map<String, String> errorMessages, String message) {
		this.tipoCategoria = tipoCategoria;
		this.validated = validated;
		this.errorMessages = errorMessages;
		this.message = message;
	}

	public TipoCategoria getTipoCategoria() {
		return tipoCategoria;
	}

	public void setTipoCategoria(TipoCategoria tipoCategoria) {
		this.tipoCategoria = tipoCategoria;
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
