<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<title>HelpDesk - Gerenciamento de Chamados</title>
		<c:url value="/resources/css" var="cssPath" />
		<c:url value="/resources/js" var="jsPath" /> 
		<c:url value="/resources/imagens" var="imgPath" /> 
		<c:url value="/resources/fontawesome" var="fontawesomePath" />
		<link rel="stylesheet" href="${cssPath}/bootstrap.min.css" type="text/css" media="all"/>
		<link rel="stylesheet" href="${cssPath}/bootstrap-grid.min.css" type="text/css" media="all"/>
		<link rel="stylesheet" href="${cssPath}/bootstrap-theme.min.css" type="text/css" media="all"/>
		<link rel="stylesheet" href="${fontawesomePath}/css/all.css" type="text/css" media="all"/>
		<link rel="icon" href="${imgPath}/favicon.ico">
		<script type="text/javascript" src="${jsPath}/jquery-3.5.1.js"></script>
		<script type="text/javascript" src="${jsPath}/bootstrap.min.js"></script>	
		<script type="text/javascript" src="${jsPath}/util.js"></script>		
	</head>

<body class="text-center"  style="background-color: #f5f5f5;">

	<header>
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark py-md-1 ">
			<a class="navbar-brand" href="<c:url value='/home'/>"  title="HelpDesk">HelpDesk</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#menu" aria-controls="menu" aria-expanded="false"
				aria-label="Alterna navegação">
				<span class="navbar-toggler-icon"></span>
			</button>
		
			<div class="collapse navbar-collapse" id="menu">
				<ul class="navbar-nav mr-auto">
						
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="nav-item">
						<security:authentication property="principal" var="usuario"/>
						<a class="nav-link"	href="#">
							<i class="fas fa-user"></i> ${usuario.username }
						</a>	
		      	 	</li>
				
					<li class="nav-item">
						<a class="nav-link"	href="<c:url value='/logout'/>">
							<i class="fas fa-sign-out-alt"  title="Sair"></i> Sair</a>					
					</li>
				</ul>
			</div>
		</nav>
	</header>

	<main role="main" style="background-color: #f5f5f5;padding: 1rem; min-height: 800px; ">
		<div class="container wrapper" style="margin-top: 100px;">
			<h2 class="display-4"><i class="fas fa-bug fa-xs"></i>  Ops... Erro 403</h2>
			 <br/>
			<p>- Acesso negado/proibido -<br/>
			   A página ou recurso que você tentou acessar está proibido por algum motivo.<br/>
			   Tente efetuar login novamente.</p>	
			   <br/>
			   <a style="color:#212529;font-size: 1.5rem;" href="<c:url value='/login'/>" ><i class="fas fa-house-user"></i> HelpDesk</a>						
		</div>
	</main>
	
	<footer class="page-footer font-small pt-4" style="background-color: #e9ecef;"> 
		<!-- Copyright -->
		<div class="footer-copyright text-center" style="padding-bottom: 2rem;">
			&copy; Prefeitura Municipal de Parobé - 2020
		</div>
	</footer>
	
</body>
</html>