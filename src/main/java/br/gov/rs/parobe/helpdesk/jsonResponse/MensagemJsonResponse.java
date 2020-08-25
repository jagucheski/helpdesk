package br.gov.rs.parobe.helpdesk.jsonResponse;

import java.util.Map;

import br.gov.rs.parobe.helpdesk.model.Mensagem;

public class MensagemJsonResponse {

	private Mensagem mensagem;
	private boolean validated;
	private Map<String, String> errorMessages;
	private String message;
	
	public MensagemJsonResponse() {
	}

	public MensagemJsonResponse(Mensagem mensagem, boolean validated, Map<String, String> errorMessages,
			String message) {
		super();
		this.mensagem = mensagem;
		this.validated = validated;
		this.errorMessages = errorMessages;
		this.message = message;
	}

	public Mensagem getMensagem() {
		return mensagem;
	}

	public void setMensagem(Mensagem mensagem) {
		this.mensagem = mensagem;
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
