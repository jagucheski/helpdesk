<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>

<tags:pageTemplate>

	<jsp:attribute name="extraScripts">
	<c:url value="/resources/js" var="jsPath" />
	<script type="text/javascript" src="${jsPath}/chamadoSolicitante.js"></script>   
</jsp:attribute>

<jsp:body>

	<main role="main" style="background-color: #f5f5f5; padding: 1rem;">
		<div class="container wrapper" >
			<form:form action="${s:mvcUrl('CSC#pesquisar').build() }" id="chamadoFindForm" method="POST">
				<h5 class="h5 mb-3 font-weight-normal">Chamado</h5>
				
				<div style="margin-left:10px">
					<div class="row">
						<label class="col-sm-1 col-form-label col-form-label-sm">Descrição:</label>
					  	<div class="form-group col-md-6" style="margin-left: -20px;">
							<input type="text" id="descricaoFind" name="descricaoFind" maxlength="60"
					       	class="form-control form-control-sm" autofocus>
						</div>	
					</div> 
				
				
					<div class="form-group row">
				    	<label class="col-sm-1 col-form-label col-form-label-sm">Criação:</label>
				   		<div class="col-md-6" style="max-width: 200px;margin-left: -20px;">
						   <input class="form-control form-control-sm" type="date" name="dataAberturaFind">
				    	</div>
				    	<label class="col-sm-1 col-form-label col-form-label-sm" style="margin-left: 10px;">Status:</label>
				    	<div class="form-group col-md-6" style="max-width: 300px;margin-left: -38px;">
							<select name="statusFind" class="form-control form-control-sm">
							 	<option value="" label="Selecione..."/> 
							    <c:forEach items="${statusChamado}" var="status">
							    	<option value="${status.valor}" label="${status.valor}"/> 
			                     </c:forEach>
							 </select>						
						</div>	
						<div class="form-group col-md-6" >
							<button type="button" class="btn btn-info btn-sm" title="Limpar" onclick="clear_form('#chamadoFindForm')" >
								<i class="fas fa-eraser"></i> Limpar</button>
							<button class="btn btn-secondary btn-sm" type="button" data-toggle="modal" data-backdrop="static" title="Novo Chamado" 
								data-target="#chamadoModal"> <i class="fas fa-plus"></i> Novo Chamado
							</button>
							<button class="btn btn-primary btn-sm" type="submit" title="Pesquisar">
								<i class="fas fa-search"></i> Pesquisar</button>
						</div>
					</div>
				</div>
						
			</form:form>
			<div id="resposta" ></div> 
		</div>
	
		<div class="container table-responsive-sm" style="margin-top: 10px !important; min-height:550px;" id="listaDeChamado">			
			 <div class="row" style="height: 20px !important;">
				 <div class="col-auto mr-auto"> 
				  	<h5 class="h5 mb-3 font-weight-normal">Lista de Chamados</h5>
				</div>	
				<div class="col-auto">
					<button id="btnExportExcel" class="btn btn-sm btn-outline-success disabled" title="Gerar Excel" onclick="exportaExcel('#tableChamado')"><i class="fas fa-file-excel"></i>  Gerar Excel</button>
				</div>			
			</div>
			<hr/>
			<table id="tableChamado" class="table table-hover table-sm table-bordered" style="text-align:center; font-size: 0.9rem; line-height: 1;">
			  	<thead class="table-active">
					<tr>
						<th>Cód</th>
						<th>Criação</th>
						<th>Status</th>
						<th>Assunto</th>
						<th>Tipo</th>
						<th>Descrição</th>
						<th>Ações</th>					
						<th>#</th>					
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${chamados}" var="chamado">
						<tr>
							<td title="${chamado.id}">${chamado.id}</td>
							
							<td title="<fmt:formatDate pattern="dd/MM/yyyy HH:mm" value="${chamado.dataAbertura}" />">
								<fmt:formatDate pattern="dd/MM/yyyy HH:mm" value="${chamado.dataAbertura}" />
							</td>
							
							 <c:choose>
								 <c:when test="${chamado.status eq 'Aguardando atendimento'}">
						         	<td title="${chamado.status}">
						         		<i class="far fa-clock"><label style="display:none;">${chamado.status}</label></i>
						         	</td>
						         </c:when>
								 <c:when test="${chamado.status eq 'Em atendimento'}">
						         	<td title="${chamado.status}"><i class="fas fa-user-cog"></i>
						         </c:when>
								 <c:when test="${chamado.status eq 'Aguardando terceiros'}">
									<td title="${chamado.status}"><i class="fas fa-user-friends"></i>
						         </c:when>
								 <c:when test="${chamado.status eq 'Aguardando retorno do solicitante'}">
									<td title="${chamado.status}"><i class="fas fa-user-clock"></i>
						         </c:when>
								 <c:when test="${chamado.status eq 'Concluído'}">
									<td title="${chamado.status} - <fmt:formatDate pattern="dd/MM/yyyy HH:mm" value="${chamado.dataEncerramento}" />"><i class="fas fa-check"></i>
						         </c:when>
					             <c:otherwise>
						            <td title="${chamado.status}">${chamado.status}</td>
						         </c:otherwise>
							 </c:choose>
							
							<td title="${chamado.categoria.nome}  ${chamado.subCategoria.nome}">${chamado.categoriaSubDesc}</td>
							<td title="${chamado.tipoCategoria.nome}">${chamado.tipoCategoria.nome}</td>
							<td title="${chamado.descricao}">${chamado.descricaoDesc}</td>
							<td>
								<div style="margin-top: -8px;">
									 <c:choose>
										 <c:when test="${chamado.status eq 'Aguardando atendimento'}">
										 	<button type="button" class="btn btn-sm"  id="btnEditarChamadoSolicitante${chamado.id}" title="Editar Chamado"
								         		onclick="openModalEditarChamadoSolicitante('${chamado.id}','${chamado.dataAberturaDesc}','${chamado.tipoCategoria.nome}','${chamado.categoria.nome}','${chamado.subCategoria.nome}')"> 
								         		<i class="far fa-edit"></i>         
											</button>
											<button type="button" class="btn btn-sm" id="btnExcluirChamadoSolicitante${chamado.id}" title="Excluir Chamado"
												data-toggle="modal" data-target="#chamadoSolicitanteExcluirModal" data-backdrop="static"
												onclick="openModalExcluirChamadoSolicitante('${chamado.id}','${chamado.solicitante.email}','${chamado.dataAberturaDesc}')"> 
												<i class="fas fa-trash"></i>
											</button>
										 </c:when>
										 <c:otherwise>
		      	 						   <button type="button" class="btn btn-sm" id="btnAddMensagemChamadoSolicitante${chamado.id}" title="Mensagens"
									           		onclick="window.location.href='${s:mvcUrl('CSC#mensagensChamadoSolicitante').arg(0, chamado.id).build() }'">  
												<i class="far fa-comments"></i>         
											</button>
											
								         </c:otherwise>
									 </c:choose>
								</div>
							</td>
							<td	title="Mensagens do chamado">
								<div style="border: 3px solid #ced4da; border-radius: 1.2rem; width:12px;padding: 0.15rem;font-size: .7rem;margin-left:20%;">
									${chamado.numeroMensagens}
								</div>
							</td>
						</tr>
					</c:forEach>
			  	</tbody>
			</table>
		</div>
			
	<%@ include file="/WEB-INF/views/chamado/chamadoSolicitanteForm.jsp" %>
			
	</main>	
	
<script type="text/javascript">

</script>
	
	
</jsp:body>

</tags:pageTemplate>
