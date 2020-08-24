<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>HelpDesk - Gerenciamento de Chamados</title>
	<c:url value="/resources/css" var="cssPath" />
	<c:url value="/resources/js" var="jsPath" />
	<link rel="stylesheet" href="${cssPath}/bootstrap.min.css" />
	<link rel="stylesheet" href="${cssPath}/bootstrap-theme.min.css" />
	<script src="${jsPath}/jquery-3.5.1.js"></script>
</head>
<body>

	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="${s:mvcUrl('HC#index').build() }">HelpDesk</a>
			</div>
			<ul class="nav navbar-nav">
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#">Page 1 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="#">Page 1-1</a></li>
						<li><a href="#">Page 1-2</a></li>
						<li><a href="#">Page 1-3</a></li>
					</ul></li>
				<li><a href="#">Page 2</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="#"><span class="glyphicon glyphicon-log-in"></span>
						Login</a></li>
			</ul>
		</div>
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
		<!-- /container -->



	<footer class="container">
		<p>&copy; Prefeitura Municipal de Parobe - 2020</p>
	</footer>


</body>
</html>