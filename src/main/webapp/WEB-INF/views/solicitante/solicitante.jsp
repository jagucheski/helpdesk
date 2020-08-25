<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>

<tags:pageTemplate >

<jsp:attribute name="extraScripts">
	<c:url value="/resources/js" var="jsPath" />
	<script type="text/javascript" src="${jsPath}/solicitante.js"></script>   
</jsp:attribute>

<jsp:body>

	<main role="main" style="background-color: #f5f5f5;padding: 1rem;">
		<div class="container wrapper" >
			<form:form action="${s:mvcUrl('SC#pesquisar').build() }" id="solicitanteFindForm" method="POST">
				<h5 class="h5 mb-3 font-weight-normal">Solicitante</h5>
				
				<div class="row">
				 	<div class="form-group col-md-6">
						<label for="nomeFind" class="sr-only">Nome</label> 
						<input type="text" id="nomeFind" name="nomeFind" 
					       class="form-control form-control-sm" placeholder="Nome" autofocus>
				 	</div>
					<div class="form-group col-md-6">
						<label for="emailFind" class="sr-only">Email</label> 
						<input type="text" id="emailFind" name="emailFind" 
				       	class="form-control form-control-sm" placeholder="Email" autofocus>
					</div> 
				</div> 
				<div class="row">
					<div class="form-group col-md-6" >
						<button type="button" class="btn btn-info btn-sm" title="Limpar" onclick="clear_form('#solicitanteFindForm')" >
							<i class="fas fa-eraser"></i> Limpar</button>
						<button class="btn btn-secondary btn-sm" type="button" data-toggle="modal" data-backdrop="static" title="Novo Solicitante" data-target="#solicitanteModal">
							<i class="fas fa-user-plus"></i> Novo Solicitante
						</button>
						<button class="btn btn-primary btn-sm" type="submit" title="Pesquisar">
							<i class="fas fa-search"></i> Pesquisar</button>
					</div>
				</div>			
			</form:form>
			
			<div id="resposta" ></div> 
		
		</div>
		<div class="container table-responsive-sm" style="margin-top: 10px !important; min-height:550px;" id="listaDeSolicitantes">
			
			 <div class="row" style="height: 20px !important;">
				 <div class="col-auto mr-auto"> 
				  	<h5 class="h5 mb-3 font-weight-normal">Lista de Solicitantes</h5>
				</div>
				<div class="col-auto">
						<button id="btnExportExcel" class="btn btn-sm btn-outline-success disabled" title="Gerar Excel" onclick="exportaExcel('#tableSolicitante')"><i class="fas fa-file-excel"></i>  Gerar Excel</button>
					<button id="btnExportPDF" class="btn btn-sm btn-outline-danger disabled" title="Gerar PDF" onclick="exportaPDF('#tableSolicitante')"><i class="fas fa-file-pdf"></i>  Gerar PDF</button>
				</div>
			</div>
			<hr/>
			<table id="tableSolicitante" class="table table-hover table-sm table-bordered" style="text-align:center;">
			  	<thead class="table-active">
					<tr>
						<th>Nome</th>
						<th>Email</th>
						<th>Telefone</th>
						<th>Ramal</th>
						<th>Ações</th>					
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${solicitantes}" var="solicitante">
						<tr>
							<td title="${solicitante.nome}">${solicitante.nome}</td>
							<td title="${solicitante.email}">${solicitante.email}</td>
							<td title="${solicitante.telefone}">${solicitante.telefone}</td>
							<td title="${solicitante.ramal}">${solicitante.ramal}</td>
							<td>
								<button type="button" class="btn btn-sm" id="btnEditarSolicitante" 
								   	onclick="openModalEditarSolicitante('${solicitante.nome}','${solicitante.email}','${solicitante.telefone}','${solicitante.ramal}','${solicitante.senha}','${solicitante.alterarSenha}')"> 
									<i class="fas fa-user-edit" title="Editar Solicitante"></i>	           
								</button>	
								<button type="button" class="btn btn-sm" id="btnAlterarSenhaSolicitante" onclick="openModalAlterarSenhaSolicitante('${solicitante.email}','${solicitante.alterarSenha}')">
									<i class="fas fa-key" title="Alterar senha do Solicitante"></i>	
								</button>
								<button type="button" class="btn btn-sm" id="btnVincularSolicitanteSetor"  
								    onclick="window.location.href='${s:mvcUrl('SC#solicitanteVincularSetor').arg(0, solicitante.email).build() }'"> 
									<i class="fas fa-building" title="Vincular Setor"></i>	           
								</button>
								
								<button type="button" class="btn btn-sm" data-toggle="modal" data-target="#solicitanteExcluirModal" data-backdrop="static"
									onclick="openModalExcluirSolicitante('#divExcluirSolicitante', '#inputEmailSolicitante', '${solicitante.email}')"> 
									<i class="fas fa-trash" title="Excluir Solicitante"></i>
								</button>												
							</td>
							
						</tr>
					</c:forEach>
			  	</tbody>
			</table>
		</div>
		
		<%@ include file="/WEB-INF/views/solicitante/solicitanteForm.jsp" %>
			
	</main>	
	
</jsp:body>

</tags:pageTemplate>		