package br.gov.rs.parobe.helpdesk.jsonResponse;

import java.util.Map;

import br.gov.rs.parobe.helpdesk.model.SubCategoria;

public class SubCategoriaJsonResponse {

	private SubCategoria subCategoria;
	private boolean validated;
	private Map<String, String> errorMessages;
	private Map<Integer, String> subCategorias;
	private String message;

	public SubCategoriaJsonResponse() {
	}

	public SubCategoriaJsonResponse(SubCategoria subCategoria, boolean validated, Map<String, String> errorMessages, String message) {
		this.subCategoria = subCategoria;
		this.validated = validated;
		this.errorMessages = errorMessages;
		this.message = message;
	}

	public SubCategoria getSubCategoria() {
		return subCategoria;
	}

	public void setSubCategoria(SubCategoria subCategoria) {
		this.subCategoria = subCategoria;
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
	
	public Map<Integer, String> getSubCategorias() {
		return subCategorias;
	}

	public void setSubCategorias(Map<Integer, String> subCategorias) {
		this.subCategorias = subCategorias;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
