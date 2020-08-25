<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>

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

<body class="text-center"  style="background-color: #f5f5f5;">

	<div class="jumbotron" style="min-height: 350px !important; margin-top:100px !important;">
		<div class="container center">
			<h1 class="display-4">Ops... Ocorreu um erro</h1>
			<p>Erro 404 - Página não encontrada.<br/>
			   Tente efetuar login novamente.</p>	
			   	<a class="navbar-brand" href="<c:url value='/login'/>" >HelpDesk</a>						
		</div>
	</div>
	
</body>
</html>