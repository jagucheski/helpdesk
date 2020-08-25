<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>

<tags:pageTemplate >

<jsp:attribute name="extraScripts">
	<c:url value="/resources/js" var="jsPath" />
	<script type="text/javascript" src="${jsPath}/usuario.js"></script>   
</jsp:attribute>

<jsp:body>

	<main role="main" style="background-color: #f5f5f5;padding: 1rem;">
		<div class="container wrapper" >
			<form:form action="${s:mvcUrl('UC#pesquisar').build() }" id="usuarioFindForm" method="POST">
				<h5 class="h5 mb-3 font-weight-normal">Usuário</h5>
				
				<div class="row">
				 	<div class="form-group col-md-6">
						<label for="nomeFind" class="sr-only">Nome</label> 
						<input type="text" id="nomeFind" name="nomeFind" 
					       class="form-control form-control-sm" placeholder="Nome" autofocus>
				 	
				 	</div>
				 	<div class="form-group col-md-6">
						<label for="perfilFind" class="sr-only">Perfil</label> 
						<select id="perfilFind" name="perfilFind"  class="form-control form-control-sm">
					        <option selected value="" label="Perfil - Selecione..."/>
					        <option value="ROLE_ADMIN" label="Administrador"/>
					        <option value="ROLE_SUP" label="Suporte"/>
					        <option value="ROLE_USER" label="Usuário"/>					       
					    </select>					       
					</div> 
				</div> 
				<div class="row">
					<div class="form-group col-md-6">
						<label for="emailFind" class="sr-only">Email</label> 
						<input type="text" id="emailFind" name="emailFind" 
				       	class="form-control form-control-sm" placeholder="Email" autofocus>
					</div> 
				</div> 
				
				<div class="row">
					<div class="form-group col-md-6" >
						<button type="button" class="btn btn-info btn-sm" title="Limpar" onclick="clear_form('#usuarioFindForm')" >
							<i class="fas fa-eraser"></i> Limpar</button>
						<button class="btn btn-secondary btn-sm" type="button" data-toggle="modal" title="Novo Usuário" data-target="#usuarioModal">
							<i class="fas fa-user-plus"></i> Novo Usuário
						</button>
						<button class="btn btn-primary btn-sm" type="submit" title="Pesquisar">
							<i class="fas fa-search"></i> Pesquisar</button>
					</div>
				</div>			
			</form:form>
			
		
			<div id="resposta" ></div> 
		
		</div>
		<div class="container table-responsive-sm" style="margin-top: 10px !important; min-height:550px;" id="listaDeUsuarios">
			
			 <div class="row" style="height: 20px !important;">
				 <div class="col-auto mr-auto"> 
				  	<h5 class="h5 mb-3 font-weight-normal">Lista de Usuários</h5>
				</div>
				<div class="col-auto">
					<button id="btnExportExcel" class="btn btn-sm btn-outline-success disabled" title="Gerar Excel"><i class="fas fa-file-excel"></i>  Gerar Excel</button>
					<button id="btnExportPDF" class="btn btn-sm btn-outline-danger disabled" title="Gerar PDF"><i class="fas fa-file-pdf"></i>  Gerar PDF</button>
				</div>
			</div>
			<hr/>
			<table id="tablePaginate" class="table table-hover table-sm table-bordered" style="text-align:center;">
			  	<thead class="table-active">
					<tr>
						<th>Nome</th>
						<th>Email</th>
						<th>Telefone</th>
						<th>Ramal</th>
						<th>Perfil</th>
						<th>Ações</th>					
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${usuarios}" var="usuario">
						<tr>
							<td title="${usuario.nome}">${usuario.nome}</td>
							<td title="${usuario.email}">${usuario.email}</td>
							<td title="${usuario.telefone}">${usuario.telefone}</td>
							<td title="${usuario.ramal}">${usuario.ramal}</td>
							<td title="Perfil: ${usuario.perfil}">${usuario.perfil}</td>
							<td>
								<button type="button" class="btn btn-sm" id="btnEditarUsuario" onclick="openModalEditarUsuario('${usuario.nome}','${usuario.email}','${usuario.telefone}','${usuario.ramal}','${usuario.senha}','${usuario.alterarSenha}')"> 
									<i class="fas fa-user-edit" title="Editar usuário"></i>	           
								</button>						
								<button type="button" class="btn btn-sm" id="btnEditarPerfilUsuario" 
								    onclick="window.location.href='${s:mvcUrl('UC#usuarioEditarPerfil').arg(0, usuario.email).build() }'"> 
									<i class="fas fa-user-tag" title="Perfil do usuário"></i>	           
								</button>	
								<button type="button" class="btn btn-sm" id="btnAlterarSenhaUsuario" onclick="openModalAlterarSenhaUsuario('${usuario.email}','${usuario.alterarSenha}')"> 
									<i class="fas fa-key" title="Alterar senha"></i>	
								</button>
								<button type="button" class="btn btn-sm" data-toggle="modal" data-target="#usuarioExcluirModal" 
									onclick="openModalExcluirUsuario('#divExcluirUsuario', '#inputEmailUsuario', '${usuario.email}')"> 
									<i class="fas fa-trash" title="Excluir"></i>
								</button>												
							</td>
							
						</tr>
					</c:forEach>
			  	</tbody>
			</table>
		</div>
		
		<%@ include file="/WEB-INF/views/usuarios/usuarioForm.jsp" %>
			
	</main>	
	
</jsp:body>

</tags:pageTemplate>		