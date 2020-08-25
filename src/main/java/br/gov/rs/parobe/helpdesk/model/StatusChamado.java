package br.gov.rs.parobe.helpdesk.model;

public enum StatusChamado {

	AGUARDANDO_ATENDIMENTO ("Aguardando atendimento"),  
	ATENDIMENTO ("Em atendimento"),			
	AGUARDANDO_TERCEIROS ("Aguardando terceiros"), 	
	AGUARDANDO_RETORNO ("Aguardando retorno do solicitante"), 	
	CONCLUIDO ("Concluído");
			
	private final String valor;

	StatusChamado(String valor) {
		this.valor = valor;
	}
	
	public String getValor() {
		return this.valor;
	}
	
}
