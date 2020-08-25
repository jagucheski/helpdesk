<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>

<tags:pageTemplate >

<jsp:attribute name="extraScripts">
	<c:url value="/resources/js" var="jsPath" />
	<script type="text/javascript" src="${jsPath}/categoria.js"></script>   
</jsp:attribute>

<jsp:body>

	<main role="main" style="background-color: #f5f5f5;padding: 1rem;">
		<div class="container wrapper" >
			<form:form action="${s:mvcUrl('CC#pesquisarCategoria').build() }" id="categoriaFindForm" method="POST">
				<h5 class="h5 mb-3 font-weight-normal">Categoria</h5>
				
				<div class="row">
				 	<div class="form-group col-md-6">
						<label for="nomeFind" class="sr-only">Nome</label> 
						<input type="text" id="nomeFind" name="nomeFind" 
					       class="form-control form-control-sm" placeholder="Nome" autofocus>
				 	</div>				 	
				</div> 
				<div class="row">
					<div class="form-group col-md-6" >
						<button type="button" class="btn btn-info btn-sm" title="Limpar" onclick="clear_form('#categoriaFindForm')" >
							<i class="fas fa-eraser"></i> Limpar</button>
						<button class="btn btn-secondary btn-sm" type="button" data-toggle="modal" data-backdrop="static" 
							title="Nova Categoria" data-target="#categoriaModal">
							<i class="fas fa-plus"></i> Nova Categoria
						</button>
						<button class="btn btn-primary btn-sm" type="submit" title="Pesquisar">
							<i class="fas fa-search"></i> Pesquisar</button>
					</div>
				</div>			
			</form:form>
			
			<div id="resposta" ></div> 
		
		</div>
		<div class="container table-responsive-sm" style="margin-top: 10px !important; min-height:550px;" id="listaDeCategorias">
			
			 <div class="row" style="height: 20px !important;">
				 <div class="col-auto mr-auto"> 
				  	<h5 class="h5 mb-3 font-weight-normal">Lista de Categoria</h5>
				</div>
				<div class="col-auto">
					<button id="btnExportExcel" class="btn btn-sm btn-outline-success disabled" title="Gerar Excel" onclick="exportaExcel('#tableCategoria')"><i class="fas fa-file-excel"></i>  Gerar Excel</button>
					<button id="btnExportPDF" class="btn btn-sm btn-outline-danger disabled" title="Gerar PDF" onclick="exportaPDF('#tableCategoria')"><i class="fas fa-file-pdf"></i>  Gerar PDF</button>
				</div>
			</div>
			<hr/>
			<table id="tableCategoria" class="table table-hover table-sm table-bordered" style="text-align:center;">
			  	<thead class="table-active">
					<tr>
						<th>Código</th>
						<th>Nome</th>
						<th>Status</th>
						<th>Ações</th>					
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${categorias}" var="categoria">
						<tr>
							<td title="${categoria.id}">${categoria.id}</td>
							<td title="${categoria.nome}">${categoria.nome}</td>
							<td title="${categoria.status == true ? 'Ativo':'Inativo'}">${categoria.status == true ? 'Ativo':'Inativo'}</td>
							<td>
								<button type="button" class="btn btn-sm" id="btnEditarCategoria${categoria.id}" 
								   	onclick="openModalEditarCategoria('${categoria.id}','${categoria.nome}','${categoria.status}')"> 
									<i class="fas fa-edit" title="Editar Categoria"></i>	           
								</button>	
								<button type="button" class="btn btn-sm" id="btnEditarSubCategoria"  
								    onclick="window.location.href='${s:mvcUrl('CC#categoriaVincularSubCategoria').arg(0, categoria.id).build() }'"> 
									<i class="fas fa-plus-circle" title="Vincular Sub-Categoria"></i>	           
								</button>
								<button type="button" class="btn btn-sm" data-toggle="modal" data-target="#categoriaExcluirModal" data-backdrop="static"
									onclick="openModalExcluirCategoria('${categoria.id}', '${categoria.nome}')"> 
									<i class="fas fa-trash" title="Excluir Categoria"></i>
								</button>												
							</td>
							
						</tr>
					</c:forEach>
			  	</tbody>
			</table>
		</div>
		
		<%@ include file="/WEB-INF/views/categoria/categoriaForm.jsp" %>
			
	</main>	
	
</jsp:body>

</tags:pageTemplate>		