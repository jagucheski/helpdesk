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
	<c:url value="/resources/js" var="jsPath" />
	<script type="text/javascript" src="${jsPath}/chamadoOperador.js"></script>   
</jsp:attribute>

<jsp:body>

	<main role="main" style="background-color: #f5f5f5; padding: 1rem;">
		<div class="container wrapper" >
			<form:form action="${s:mvcUrl('COC#pesquisar').build() }" id="chamadoFindForm" method="POST">
				<h5 class="h5 mb-3 font-weight-normal">Gerenciar/Chamados</h5>
				
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
				   		<div class="col-md-6" style="max-width: 142px;margin-left: -20px;">
						   <input class="form-control form-control-sm" type="text" maxlength="4" name="dataAberturaFind"
						   		  placeholder="Ano de Criação" autofocus onkeydown="javascript: fMasc( this, mNum );" onchange="javascript: fMasc( this, mNum );"
									oninput="javascript: fMasc( this, mNum );">
				    	</div>
				    	<label class="col-sm-1 col-form-label col-form-label-sm" style="margin-left: 68px;">Status:</label>
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
							<button class="btn btn-secondary btn-sm" type="button" data-toggle="modal" data-backdrop="static" title="Abrir Chamado do Solicitante" 
								data-target="#chamadoSolicitanteModal"> <i class="fas fa-plus"></i> Abrir Chamado</button>
							<button class="btn btn-primary btn-sm" type="submit" title="Pesquisar">
								<i class="fas fa-search"></i> Pesquisar</button>
						</div>
					</div>
				</div>
			
			</form:form>
			<div id="resposta" ></div> 
		</div>
	
		<div class="container table-responsive-sm" style="margin-top: 10px !important; min-height:550px;" id="listaDeChamados">			
			 <div class="row" style="height: 20px !important;">
				 <div class="col-auto mr-auto"> 
				  	<h5 class="h5 mb-3 font-weight-normal">Lista de Chamados</h5>
				</div>	
				<div class="col-auto">
					<button id="btnExportExcel" class="btn btn-sm btn-outline-success disabled" title="Gerar Excel" onclick="exportaExcel('#tableChamados')"><i class="fas fa-file-excel"></i>  Gerar Excel</button>
				</div>			
			</div>
			<hr/>
			<table id="tableChamados" class="table table-hover table-sm table-bordered" style="text-align:center; font-size: 0.9rem; line-height: 1;">
			  	<thead class="table-active">
					<tr>
						<th>Cód</th>
						<th>Criação</th>
						<th>Status</th>
						<th>Assunto</th>
						<th>Descrição</th>
						<th>Solicitante</th>
						<th>Ações</th>					
						<th>#</th>					
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${chamados}" var="chamado">
						<tr>
							<td title="${chamado.id}">${chamado.id}</td>
							
							<td title="<fmt:formatDate pattern="dd/MM/yyyy HH:mm" value="${chamado.dataAbertura}"/>">
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
							
							<td title="${chamado.categoria.nome} / ${chamado.subCategoria.nome} / ${chamado.tipoCategoria.nome}">${chamado.categoriaSubDesc}</td>
							<td title="${chamado.descricao}">${chamado.descricaoDesc}</td>
							<td title="${chamado.solicitante.nome} - ${chamado.solicitante.email}">${chamado.solicitante.nome}</td>
							<td>
								<div style="margin-top: -8px;width: 103%;">
									<button type="button" class="btn btn-sm" id="btnVisualizarChamadoSolicitante${chamado.id}" title="Visualizar Chamado"
						           	    onclick="openModalVisualizarChamado('${chamado.id}','${chamado.dataAberturaDesc}','${chamado.tipoCategoria.nome}','${chamado.categoria.nome}','${chamado.subCategoria.nome}','${chamado.setor.nome}', '${chamado.solicitante.nome}- ${chamado.solicitante.email}')">  
										<i class="far fa-file"></i>         
									</button>
									 <c:choose>
										 <c:when test="${chamado.status eq 'Aguardando atendimento'}">
								         	<button type="button" class="btn btn-sm" id="btnIniciarAtendimentoChamado${chamado.id}" title="Iniciar Atendimento"
								         		onclick="window.location.href='${s:mvcUrl('COC#chamadoIniciarAtendimento').arg(0, chamado.id).build() }'"> 
								         		<i class="fas fa-play"></i>      
											</button>
											<button type="button" class="btn btn-sm" id="btnExcluirChamado${chamado.id}" title="Excluir Chamado"
												data-toggle="modal" data-target="#chamadoExcluirModal" data-backdrop="static"
												onclick="openModalExcluirChamado('${chamado.id}','${chamado.solicitante.email}','${chamado.solicitante.nome}','${chamado.dataAberturaDesc}')"> 
												<i class="fas fa-trash"></i>
											</button>
										 </c:when>
										 <c:when test="${chamado.status eq 'Em atendimento' or chamado.status eq 'Aguardando terceiros' or chamado.status eq 'Aguardando retorno do solicitante'}">
								           <button type="button" class="btn btn-sm" id="btnVisualizarMensagens${chamado.id}" title="Mensagens"
								           		 onclick="window.location.href='${s:mvcUrl('COC#mensagensChamadoOperador').arg(0, chamado.id).build() }'">  
												<i class="far fa-comments"></i>       
											</button>
										   <button type="button" class="btn btn-sm" id="btnAddMensagem${chamado.id}" title="Finalizar Chamado"  
								           		data-toggle="modal" data-target="#chamadoFinalizarModal" data-backdrop="static"
								           		onclick="openModalFinalizarChamado('${chamado.id}','${chamado.solicitante.email}','${chamado.solicitante.nome}','${chamado.dataAberturaDesc}','${chamado.categoria.nome} - ${chamado.subCategoria.nome}')">
												<i class="fas fa-check"></i>         
											</button>											
										 </c:when>
										 <c:when test="${chamado.status eq 'Concluído'}">
								           <button type="button" class="btn btn-sm" id="btnVisualizarMensagens${chamado.id}" title="Mensagens"
								           		 onclick="window.location.href='${s:mvcUrl('COC#mensagensChamadoOperador').arg(0, chamado.id).build() }'">  
												<i class="far fa-comments"></i>       
											</button>
										 </c:when>
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
			
	<%@ include file="/WEB-INF/views/chamado/chamadoOperadorForm.jsp" %>
			
	</main>	
	
<script type="text/javascript">

</script>
	
	
</jsp:body>

</tags:pageTemplate>
