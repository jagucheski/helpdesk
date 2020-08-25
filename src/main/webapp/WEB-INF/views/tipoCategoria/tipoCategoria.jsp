<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>

<tags:pageTemplate >

<jsp:attribute name="extraScripts">
	<c:url value="/resources/js" var="jsPath" />
	<script type="text/javascript" src="${jsPath}/tipoCategoria.js"></script>   
</jsp:attribute>

<jsp:body>

	<main role="main" style="background-color: #f5f5f5;padding: 1rem;">
		<div class="container wrapper" >
			<form:form action="${s:mvcUrl('TCC#pesquisarTipoCategoria').build() }" id="tipoCategoriaFindForm" method="POST">
				<h5 class="h5 mb-3 font-weight-normal">Tipo Categoria</h5>
				
				<div class="row">
				 	<div class="form-group col-md-6">
						<label for="nomeFind" class="sr-only">Nome</label> 
						<input type="text" id="nomeFind" name="nomeFind" 
					       class="form-control form-control-sm" placeholder="Nome" autofocus>
				 	</div>
				 	<div class="form-group col-md-6">
						<label for="nomeFind" class="sr-only">Descrição</label> 
						<input type="text" id="descricaoFind" name="descricaoFind" 
					       class="form-control form-control-sm" placeholder="Descrição" autofocus>
				 	</div>
				</div> 
				<div class="row">
					<div class="form-group col-md-6" >
						<button type="button" class="btn btn-info btn-sm" title="Limpar" onclick="clear_form('#tipoCategoriaFindForm')" >
							<i class="fas fa-eraser"></i> Limpar</button>
						<button class="btn btn-secondary btn-sm" type="button" data-toggle="modal" data-backdrop="static" 
							title="Novo TipoCategoria" data-target="#tipoCategoriaModal">
							<i class="fas fa-plus"></i> Novo Tipo Categoria
						</button>
						<button class="btn btn-primary btn-sm" type="submit" title="Pesquisar">
							<i class="fas fa-search"></i> Pesquisar</button>
					</div>
				</div>			
			</form:form>
			
			<div id="resposta" ></div> 
		
		</div>
		<div class="container table-responsive-sm" style="margin-top: 10px !important; min-height:550px;" id="listaDeTipoCategorias">
			
			 <div class="row" style="height: 20px !important;">
				 <div class="col-auto mr-auto"> 
				  	<h5 class="h5 mb-3 font-weight-normal">Lista de Tipo Categoria</h5>
				</div>
				<div class="col-auto">
						<button id="btnExportExcel" class="btn btn-sm btn-outline-success disabled" title="Gerar Excel" onclick="exportaExcel('#tableTipoCategoria')"><i class="fas fa-file-excel"></i>  Gerar Excel</button>
					<button id="btnExportPDF" class="btn btn-sm btn-outline-danger disabled" title="Gerar PDF" onclick="exportaPDF('#tableTipoCategoria')"><i class="fas fa-file-pdf"></i>  Gerar PDF</button>
				</div>
			</div>
			<hr/>
			<table id="tableTipoCategoria" class="table table-hover table-sm table-bordered" style="text-align:center;">
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
					<c:forEach items="${tipoCategorias}" var="tipoCategoria">
						<tr>
							<td title="${tipoCategoria.id}">${tipoCategoria.id}</td>
							<td title="${tipoCategoria.nome}">${tipoCategoria.nome}</td>
							<td title="${tipoCategoria.descricao}">${tipoCategoria.descricao}</td>
							<td title="${tipoCategoria.status == true ? 'Ativo':'Inativo'}">${tipoCategoria.status == true ? 'Ativo':'Inativo'}</td>
							<td>
								<button type="button" class="btn btn-sm" id="btnEditarTipoCategoria" 
								   	onclick="openModalEditarTipoCategoria('${tipoCategoria.id}','${tipoCategoria.nome}','${tipoCategoria.descricao}','${tipoCategoria.status}')"> 
									<i class="fas fa-edit" title="Editar TipoCategoria"></i>	           
								</button>	
								<button type="button" class="btn btn-sm" data-toggle="modal" data-target="#tipoCategoriaExcluirModal" data-backdrop="static"
									onclick="openModalExcluirTipoCategoria('${tipoCategoria.id}', '${tipoCategoria.nome}')"> 
									<i class="fas fa-trash" title="Excluir TipoCategoria"></i>
								</button>												
							</td>
							
						</tr>
					</c:forEach>
			  	</tbody>
			</table>
		</div>
		
		<%@ include file="/WEB-INF/views/tipoCategoria/tipoCategoriaForm.jsp" %>
			
	</main>	
	
</jsp:body>

</tags:pageTemplate>		