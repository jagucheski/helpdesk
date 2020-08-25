<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<link rel="stylesheet" href="${cssPath}/bootstrap.min.css" type="text/css" media="all"/>
	<link rel="stylesheet" href="${cssPath}/bootstrap-theme.min.css" type="text/css" media="all"/>
	<link rel="icon" href="${imgPath}/favicon.ico">
	<script src="${jsPath}/jquery-3.5.1.js"></script>
	<script src="${jsPath}/bootstrap.min.js"></script>		
	<script src="https://kit.fontawesome.com/16323492c4.js" crossorigin="anonymous"></script>
</head>

<body class="text-center" style="background-color: #f5f5f5;">

	<div class="container wrapper" style="width:350px; margin-top:120px;" >
		<form:form class="form-signin" servletRelativeAction="/login" method="post">
			<img class="mb-4" src="${imgPath}/brasao.png" alt="HelpDesk" width="71">
			<h1 class="h3 mb-3 font-weight-normal">HelpDesk - Login</h1>
			
			<div class="form-group">
				<label for="username" class="sr-only">Email</label> 
				<input type="email" id="username" name="username" 
			       class="form-control form-control-sm" placeholder="Email" autofocus>
			</div> 
			<div class="form-group">
				<label for="password" class="sr-only">Senha</label> 
				<input type="password" id="password" name="password" 
					   class="form-control form-control-sm" placeholder="Senha">
			</div>
			
			<div class="form-group">
				<button class="btn btn-primary btn-block btn-sm" type="submit" title="Entrar">
				<i class="fas fa-sign-in-alt"></i>  Entrar</button>				
				
			</div>
			
			<c:if test="${param.error != null}">
			    <div class="alert alert-danger talert-dismissible fade show" style='font-size: .875rem;' role='alert'>
			    	<button type='button' class='close' data-dismiss='alert' aria-label='Close'>
			    		<span aria-hidden='true'>&times;</span>
			    	</button>
			              Falha ao fazer Login.<br/>
                          Verifique suas credenciais
                </div>
            </c:if>
           
			<p class="mt-5 mb-3 text-muted">&copy; Prefeitura Municipal de Parobé - 2020</p>
			
		</form:form>
	</div>
</body>
</html>
