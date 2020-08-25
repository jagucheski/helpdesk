<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>HelpDesk - Gerenciamento de Chamados</title>
	<c:url value="/resources/css" var="cssPath" />
	<c:url value="/resources/js" var="jsPath" /> 
	<c:url value="/resources/imagens" var="imgPath" /> 
	<link rel="stylesheet" href="${cssPath}/bootstrap.min.css" />
	<link rel="stylesheet" href="${cssPath}/bootstrap-theme.min.css" />
	<link rel="icon" href="${imgPath}/favicon.ico">
	<script src="${jsPath}/jquery-3.5.1.js"></script>
	<script src="${jsPath}/bootstrap.min.js"></script>
	
</head>
<body style="background-color: #f5f5f5;">

	<nav class="navbar navbar-inverse navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="${s:mvcUrl('HC#home').build() }">
				<span class="glyphicon glyphicon-home"></span> 	HelpDesk</a>
			</div>
		
			<ul class="nav navbar-nav navbar-right">
				<li>
					<a href="<c:url value="/logout" />">
					<span class="glyphicon glyphicon-log-out"></span> Sair</a>
				</li>
<!-- 	      	 	<li class="nav-item"> -->
<!-- 	      	 		<a href="#"> -->
<%-- 	      	 			<security:authentication property="principal" var="usuario" /> --%>
<%-- 	      	 			${usuario.username } --%>
<!-- 	      	 		</a> -->
<!-- 	      	 	</li> -->
	      	</ul>			
		</div>
	</nav>

	<nav class="navbar ">
		<ul class="nav flex-column">
		  <li class="nav-item">
		    <a class="nav-link active" href="#">Active</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="#">Link</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="#">Link</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
		  </li>
		</ul>
	</nav>

		<div class="jumbotron" style="min-height: 400px !important;">
			<div class="container">
				<h2 class="display-3">Seja bem-vindo!</h2>
				<p>Esta é a pagina do Departamento de TI.<br/>
				Aqui você tem acesso a documentos, manuais, formulários de solicitação, perguntas frequentes e mais.<br/>
				Além disso é possível acessar o sistema de abertura de chamados.</p>				
			</div>
		</div>

		<div class="container">
			<div class="row">
				<div class="col-md-4">
					<h3>Contato</h3>
					Telefone:<br/> 
					<ul>
						<li>(51) 3543.8600 Ramal: 212 ou </li>
					</ul>
					E-mail:<br/>
					<ul> 
						<li>ti.parobe@parobe.rs.gov.br</li>
						<li>suporte.ti@parobe.rs.gov.br</li>
					</ul>					
				</div>
				
				<div class="col-md-4">
					<h3>Atendimento</h3>
					<ul> 
						<li>Segunda das 12h às 18h</li>
						<li>terça das 7h à 13h</li>
						<li>quarta das 7h à 13h</li>
						<li>quinta das 7h à 13h</li>
						<li>sexta das 7h à 13h</li>
					</ul>	
				</div>
				
				<div class="col-md-4">
					<h3>Endereço</h3>
					<p>Av. João Mosmann Filho, nº 143, 4° andar, Sala 41, Centro, Parobé.</p>
				</div>
			</div>
			<hr>
		</div>
	

</body>
</html>