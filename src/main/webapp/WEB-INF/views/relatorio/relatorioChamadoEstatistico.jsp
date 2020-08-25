<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>

<tags:pageTemplate>

<jsp:attribute name="extraScripts">
</jsp:attribute>

<jsp:body>

	<main role="main" style="background-color: #f5f5f5; padding: 1rem;min-height: 830px;">
		<div class="container wrapper" >
			<form:form action="${s:mvcUrl('RCC#pesquisar').build() }" id="relatorioChamadoFindForm" commandName="chamadoDtoFind" method="POST">
				<h5 class="h5 mb-3 font-weight-normal">Relatórios/Chamados - Estatístico</h5>
				
				<div class="row" style="margin-top: 20px;">
					
					<label class="col-sm-1 col-form-label col-form-label-sm" style="margin-left: 25px;">Ano:</label>
			   		<div class="col-md-6" style="max-width: 142px;margin-left: -50px;">
					   <input class="form-control form-control-sm" type="text" maxlength="4" name="anoCricao"  style="width:120px;display: inline;"
	   		  					placeholder="Ano de Criação" autofocus onkeydown="javascript: fMasc( this, mNum );" onchange="javascript: fMasc( this, mNum );" 
 									oninput="javascript: fMasc( this, mNum );">	
			    	</div>
					
					<label class="col-sm-1 col-form-label col-form-label-sm" style="margin-left: 25px;">Mês:</label>
			   		<div class="col-md-6" style="max-width: 135px;margin-left: -50px;">
						<form:select id="selectSetor" path="mesCriacao" class="form-control form-control-sm">
						    <form:option value="">Selecione...</form:option>
						    <form:option value="01">Janeiro</form:option>
						    <form:option value="02">Fevereiro</form:option>
						    <form:option value="03">Março</form:option>
						    <form:option value="04">Abril</form:option>
						    <form:option value="05">Maio</form:option>
						    <form:option value="06">Junho</form:option>
						    <form:option value="07">Julho</form:option>
						    <form:option value="08">Agosto</form:option>
						    <form:option value="09">Setembro</form:option>
						    <form:option value="10">Outubro</form:option>
						    <form:option value="11">Novembro</form:option>
						    <form:option value="12">Dezembro</form:option>
						</form:select>			
			    	</div>
					
					<label class="col-sm-1 col-form-label col-form-label-sm" style="margin-left: 25px;">Setor:</label>
			    	<div class="form-group col-md-6" style="max-width:250px;margin-left: -50px;">
						<form:select id="selectSetor" path="setor" class="form-control form-control-sm">
						    <form:option value="">Selecione...</form:option>
						    <form:options items="${setores}" itemLabel="nome" itemValue="nome"/>
					    </form:select>				
					</div>
			    	
			    	<label class="col-sm-1 col-form-label col-form-label-sm" style="margin-left: 25px;">Status:</label>
			   		<div class="col-md-6" style="max-width: 275px;margin-left: -40px;">
						<form:select id="selectSetor" path="status" class="form-control form-control-sm" >
						    <form:option value="">Selecione...</form:option>
						    <form:options items="${statusList}" itemValue="valor" itemLabel="valor" /> 
						</form:select>			
			    	</div>
					
					<div class="form-group col-md-6" >
						<button type="button" class="btn btn-info btn-sm" title="Limpar" onclick="clear_form('#relatorioChamadoFindForm')" style="margin-left:15px;margin-bottom:4px;">
							<i class="fas fa-eraser"></i> Limpar</button>
						<button class="btn btn-primary btn-sm" type="submit" title="Pesquisar" style="margin-bottom:4px;">
							<i class="fas fa-search"></i> Pesquisar</button>
					</div>
				</div>	
			</form:form>
			<div id="resposta" ></div> 
		</div>
	
		<div class="container table-responsive-sm" style="margin-top: 10px !important; min-height:550px;" id="listaRelatorioChamados">			
			 <div class="row" style="height: 20px !important;">
				 <div class="col-auto mr-auto"> 
				  	<h5 class="h5 mb-3 font-weight-normal">Relatório de Chamados</h5>
				</div>	
				<div class="col-auto">
					<button id="btnExportExcel" class="btn btn-sm btn-outline-success disabled" title="Gerar Excel" onclick="exportaExcel('#tableRelatorioChamados')"><i class="fas fa-file-excel"></i>  Gerar Excel</button>
				</div>			
			</div>
			<hr/>
			<table id="tableRelatorioChamados" class="table table-hover table-sm table-bordered" style="text-align:center; font-size: 0.9rem; line-height: 1;">
			  	<thead class="table-active">
					<tr>
						<th>Ano</th>
						<th>Mês</th>
						<th>Setor</th>
						<th>Solicitante</th>
						<th>Status</th>
						<th>Qtde</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${relatorioChamados}" var="relatorioChamado">
						<tr>
							<td title="${relatorioChamado.anoCriacao}">${relatorioChamado.anoCriacao}  </td>
							<td title="${relatorioChamado.mesCriacaoDesc}">${relatorioChamado.mesCriacaoDesc}  </td>
							<c:choose>
							    <c:when test="${empty relatorioChamado.setor}">
							       <td title="Sem setor vinculado">Sem setor vinculado </td>  
							    </c:when>
							    <c:otherwise>
							        <td title="${relatorioChamado.setor}">${relatorioChamado.setor}  
							    </c:otherwise>
							</c:choose>
							<td title="${relatorioChamado.solicitante}">${relatorioChamado.solicitante}  </td>
							<td title="${relatorioChamado.status}">${relatorioChamado.status}  </td>							
							<td title="${relatorioChamado.qtde}">${relatorioChamado.qtde}  </td>							
						</tr>
					</c:forEach>
			  	</tbody>
			  	<tfoot>
					<tr>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th title="Total de Chamados">Total: <span id="total"></span></th>
					</tr>
				</tfoot>
			</table>
		</div>
			
	</main>	
	
<script type="text/javascript">


/** https://datatables.net/*/
/**
* Configuração padrão das tabelas
**/
$(document).ready(function() {
	$('#tableRelatorioChamados').dataTable({
		 responsive: true,
		"pageLength": 25,
		"lengthMenu": [ [25,50,100, -1], [25,50,100, "Todos"]],
		"language" : {
		    "search":         "Filtrar:",
			"emptyTable":     "Nenhum registro encontrado",
		    "info":           "Mostrando _START_ até _END_ de _TOTAL_ registros",
		    "infoEmpty":      "Mostrando 0 até 0 de 0 registros",
		    "infoFiltered":   " ( Filtrado de _MAX_ registros )",
		    "lengthMenu":     "Mostrar _MENU_ registros",
		    "loadingRecords": "Carregando...",
		    "processing":     "Processando...",
		    "zeroRecords":    "Nenhum registro encontrado de acordo com o filtro",
			"paginate": {
			        "first":      "Primeira",
			        "last":       "Última",
			        "next":       "Próxima",
			        "previous":   "Anterior"
			    }				
		}
	});

});


//Gerar Excel da tabela    
function exportaExcel(idtable) {
	// parse the HTML table element having an id=tablePaginate
	var dataSource = shield.DataSource.create({
		data: idtable,
		schema: {
			type: "table",
			fields: {
				Ano: { type: String },
				Mês: { type: String },
				Setor: { type: String },
				Solicitante: { type: String },
				Status: { type: String },
				Qtde: { type: String }
			}
		}
	});

	// when parsing is done, export the data to Excel
	dataSource.read().then(function(data) {
		new shield.exp.OOXMLWorkbook({
			author: "HelpDesk",
			worksheets: [
				{
					name: "HelpDesk Table",
					rows: [
						{
							cells: [
								{
									style: {
										bold: true
									},
									type: String,
									value: "Ano"
								},
								{
									style: {
										bold: true
									},
									type: String,
									value: "Mês"
								},
								{
									style: {
										bold: true
									},
									type: String,
									value: "Setor"
								},
								{
									style: {
										bold: true
									},
									type: String,
									value: "Solicitante"
								},
								{
									style: {
										bold: true
									},
									type: String,
									value: "Status"
								},
								{
									style: {
										bold: true
									},
									type: String,
									value: "Qtde"
								}								
							]
						}
					].concat($.map(data, function(item) {
						return {
							cells: [
								{ type: String, value: item.Ano },
								{ type: String, value: item.Mês },
								{ type: String, value: item.Setor },
								{ type: String, value: item.Solicitante },
								{ type: String, value: item.Status },
								{ type: String, value: item.Qtde }
							]
						};
					}))
				}
			]
		}).saveAs({
			fileName: "helpdesk_chamados_Excel"
		});
	});
}

//totalizador de chamados
$(document).ready(function() {
	 var sum = $('#tableRelatorioChamados').DataTable().column(5).data().sum();
     $('#total').html(sum);
} );

</script>
	
	
</jsp:body>

</tags:pageTemplate>
