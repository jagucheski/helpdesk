package br.gov.rs.parobe.helpdesk.dto;

public class ChamadoMesStatusDto {

	private String status;
	private Long qtde;

	public ChamadoMesStatusDto() {
	}

	public ChamadoMesStatusDto(String status, Long qtde) {
		this.status = status;
		this.qtde = qtde;
	}

		public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Long getQtde() {
		return qtde;
	}

	public void setQtde(Long qtde) {
		this.qtde = qtde;
	}

}
