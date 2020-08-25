package br.gov.rs.parobe.helpdesk.model;

public enum Roles {

	ROLE_ADMIN ("Administrador"), 
	ROLE_USER ("Usuário"), 
	ROLE_SUP ("Suporte");
	
	private final String valor;
	
	Roles(String valorOpcao){
		valor = valorOpcao;
	}
	
	public String getValor(){
		return valor;
	}
}
