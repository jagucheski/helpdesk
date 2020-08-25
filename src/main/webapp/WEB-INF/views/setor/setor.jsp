<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>

<tags:pageTemplate >

<jsp:attribute name="extraScripts">
	<c:url value="/resources/js" var="jsPath" />
	<script type="text/javascript" src="${jsPath}/setor.js"></script>   
</jsp:attribute>

<jsp:body>

	<main role="main" style="background-color: #f5f5f5;padding: 1rem;">
		<div class="container wrapper" >
			<form:form action="${s:mvcUrl('SC#pesquisarSetor').build() }" id="setorFindForm" method="POST">
				<h5 class="h5 mb-3 font-weight-normal">Setor</h5>
				
				<div class="row">
				 	<div class="form-group col-md-6">
						<label for="nomeFind" class="sr-only">Nome</label> 
						<input type="text" id="nomeFind" name="nomeFind" 
					       class="form-control form-control-sm" placeholder="Nome" autofocus>
				 	</div>				 	
				 	<div class="form-group col-md-6">
						<label for="descricaoFind" class="sr-only">Descricao</label> 
						<input type="text" id="descricaoFind" name="descricaoFind" 
				       	class="form-control form-control-sm" placeholder="Descrição" autofocus>
					</div> 
				</div> 
				<div class="row">
					<div class="form-group col-md-6" >
						<button type="button" class="btn btn-info btn-sm" title="Limpar" onclick="clear_form('#setorFindForm')" >
							<i class="fas fa-eraser"></i> Limpar</button>
						<button class="btn btn-secondary btn-sm" type="button" data-toggle="modal" data-backdrop="static" 
							title="Novo Setor" data-target="#setorModal">
							<i class="fas fa-plus"></i> Novo Setor
						</button>
						<button class="btn btn-primary btn-sm" type="submit" title="Pesquisar">
							<i class="fas fa-search"></i> Pesquisar</button>
					</div>
				</div>			
			</form:form>
			
			<div id="resposta" ></div> 
		
		</div>
		<div class="container table-responsive-sm" style="margin-top: 10px !important; min-height:550px;" id="listaDeSetores">
			
			 <div class="row" style="height: 20px !important;">
				 <div class="col-auto mr-auto"> 
				  	<h5 class="h5 mb-3 font-weight-normal">Lista de Setores</h5>
				</div>
				<div class="col-auto">
						<button id="btnExportExcel" class="btn btn-sm btn-outline-success disabled" title="Gerar Excel" onclick="exportaExcel('#tableSetor')"><i class="fas fa-file-excel"></i>  Gerar Excel</button>
					<button id="btnExportPDF" class="btn btn-sm btn-outline-danger disabled" title="Gerar PDF" onclick="exportaPDF('#tableSetor')"><i class="fas fa-file-pdf"></i>  Gerar PDF</button>
				</div>
			</div>
			<hr/>
			<table id="tableSetor" class="table table-hover table-sm table-bordered" style="text-align:center;">
			  	<thead class="table-active">
					<tr>
						<th>Código</th>
						<th>Nome</th>
						<th>Descrição</th>
						<th>Status</th>
						<th>Ações</th>					
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${setores}" var="setor">
						<tr>
							<td title="${setor.id}">${setor.id}</td>
							<td title="${setor.nome}">${setor.nome}</td>
							<td title="${setor.descricao}">${setor.descricao}</td>
							<td title="${setor.status == true ? 'Ativo':'Inativo'}">${setor.status == true ? 'Ativo':'Inativo'}</td>
							<td>
								<button type="button" class="btn btn-sm" id="btnEditarSetor" 
								   	onclick="openModalEditarSetor('${setor.id}','${setor.nome}','${setor.descricao}','${setor.status}')"> 
									<i class="fas fa-edit" title="Editar Setor"></i>	           
								</button>	
								<button type="button" class="btn btn-sm" data-toggle="modal" data-target="#setorExcluirModal" data-backdrop="static"
									onclick="openModalExcluirSetor('${setor.id}', '${setor.nome}')"> 
									<i class="fas fa-trash" title="Excluir Setor"></i>
								</button>												
							</td>
							
						</tr>
					</c:forEach>
			  	</tbody>
			</table>
		</div>
		
		<%@ include file="/WEB-INF/views/setor/setorForm.jsp" %>
			
	</main>	
	
</jsp:body>

</tags:pageTemplate>		