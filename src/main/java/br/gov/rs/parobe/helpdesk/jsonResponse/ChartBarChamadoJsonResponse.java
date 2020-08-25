package br.gov.rs.parobe.helpdesk.jsonResponse;

public class ChartBarChamadoJsonResponse {

	private boolean validated;
	private String message;
	private String titulo;
	private String subTitulo;
	private String data;

	public ChartBarChamadoJsonResponse() {
	}

	public ChartBarChamadoJsonResponse(boolean validated, String message, String titulo, String subTitulo,
			String data) {
		super();
		this.validated = validated;
		this.message = message;
		this.titulo = titulo;
		this.subTitulo = subTitulo;
		this.data = data;
	}

	public boolean isValidated() {
		return validated;
	}

	public void setValidated(boolean validated) {
		this.validated = validated;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public String getSubTitulo() {
		return subTitulo;
	}

	public void setSubTitulo(String subTitulo) {
		this.subTitulo = subTitulo;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

}
