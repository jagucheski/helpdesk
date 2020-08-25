<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>

<tags:pageTemplate bodyClass="background-color: #f5f5f5;">


	<div class="jumbotron" style="min-height: 600px !important; margin-top: -35px !important;" >  
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
				        <option selected>Perfil...</option>
				        <option>...</option>
				    </select>
				       
				</div> 
			</div> 
			<div class="row">
				<div class="form-group col-md-6">
					<label for="emailFind" class="sr-only">Email</label> 
					<input type="email" id="emailFind" name="emailFind" 
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
		
	
		<div id="resposta"></div> 
	
	</div>
	
	
	<div class="container table-responsive-sm" style="margin-top: 20px !important;" id="listaDeUsuarios">
	<h5 class="h5 mb-3 font-weight-normal">Lista de Usuários</h5>
	<hr/>
		<table class="table table-hover table-sm table-bordered" style="text-align:center;">
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
			<c:forEach items="${usuarios}" var="usuario">
				<tr>
					<td>${usuario.nome}</td>
					<td>${usuario.email}</td>
					<td>${usuario.telefone}</td>
					<td>${usuario.ramal}</td>
					<td>${usuario.roles}</td>
					<td>
						<form:form action="${s:mvcUrl('UC#deletar').arg(0, usuario.email).build() }" method="POST">
							<button type="submit" class="btn btn-sm">
								<i class="fas fa-trash" title="Excluir"></i>
							</button>
						</form:form>
					</td>

				</tr>
			</c:forEach>
		</table>
	</div>
	
</div>

	<%@ include file="/WEB-INF/views/usuarioForm.jsp" %>	
		
</tags:pageTemplate>		