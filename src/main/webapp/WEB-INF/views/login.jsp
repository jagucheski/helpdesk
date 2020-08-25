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
	<c:url value="/resources/imagens" var="imgPath" /> 
	<link rel="stylesheet" href="${cssPath}/bootstrap.min.css" />
	<link rel="stylesheet" href="${cssPath}/bootstrap-theme.min.css" />
	<link rel="icon" href="${imgPath}/favicon.ico">
	<script src="${jsPath}/jquery-3.5.1.js"></script>
	<script src="${jsPath}/bootstrap.min.js"></script>
	
</head>
<body class="text-center" style="background-color: #f5f5f5;">

	<div class="container " style=" width: 350px; margin-top: 120px;" >
		<form class="form-signin">
			<img class="mb-4" src="${imgPath}/brasao.png" alt="HelpDesk" width="71">
			<h1 class="h3 mb-3 font-weight-normal">HelpDesk - Login</h1>
		 	<div class="form-group">
				<label for="email" class="sr-only">Email</label> 
				<input type="email" id="email" name="email" 
			       class="form-control" placeholder="Email" autofocus>
			</div> 
			<div class="form-group">
				<label for="password" class="sr-only">Senha</label> 
				<input type="password" id="password" name="senha" 
					   class="form-control" placeholder="Senha">
			</div>
			
			<div class="form-group">
				<button class="btn btn-lg btn-primary btn-block" type="submit">Entrar</button>
			</div>
			<p class="mt-5 mb-3 text-muted">&copy; Prefeitura Municipal de Parobe - 2020</p>
		</form>
	</div>



<!-- 	<nav class="navbar navbar-inverse"> -->
<!-- 		<div class="container-fluid"> -->
<!-- 			<div class="navbar-header"> -->
<%-- 				<a class="navbar-brand" href="${s:mvcUrl('HC#index').build() }">HelpDesk</a> --%>
<!-- 			</div> -->
<!-- 			<ul class="nav navbar-nav"> -->
<!-- 				<li class="dropdown"><a class="dropdown-toggle" -->
<%-- 					data-toggle="dropdown" href="#">Page 1 <span class="caret"></span></a> --%>
<!-- 					<ul class="dropdown-menu"> -->
<!-- 						<li><a href="#">Page 1-1</a></li>						 -->
<!-- 					</ul></li> -->
<!-- 				<li><a href="#">Page 2</a></li> -->
<!-- 			</ul> -->
<!-- 			<ul class="nav navbar-nav navbar-right"> -->
<%-- 				<li><a href="#"><span class="glyphicon glyphicon-log-in"></span> --%>
<!-- 						Login</a></li> -->
<!-- 			</ul> -->
<!-- 		</div> -->
<!-- 	</nav> -->




<!-- 		<div class="jumbotron" style="min-height: 400px !important;"> -->
<!-- 			<div class="container"> -->
<!-- 				<h2 class="display-3">Seja bem-vindo!</h2> -->
<!-- 				<p>Esta é a pagina do Departamento de TI.<br/> -->
<!-- 				Aqui você tem acesso a documentos, manuais, formulários de solicitação, perguntas frequentes e mais.<br/> -->
<!-- 				Além disso é possível acessar o sistema de abertura de chamados.</p>				 -->
<!-- 			</div> -->
<!-- 		</div> -->

<!-- 		<div class="container"> -->
<!-- 			<div class="row"> -->
<!-- 				<div class="col-md-4"> -->
<!-- 					<h3>Contato</h3> -->
<!-- 					Telefone:<br/>  -->
<!-- 					<ul> -->
<!-- 						<li>(51) 3543.8600 Ramal: 212 ou </li> -->
<!-- 					</ul> -->
<!-- 					E-mail:<br/> -->
<!-- 					<ul>  -->
<!-- 						<li>ti.parobe@parobe.rs.gov.br</li> -->
<!-- 						<li>suporte.ti@parobe.rs.gov.br</li> -->
<!-- 					</ul>					 -->
<!-- 				</div> -->
				
<!-- 				<div class="col-md-4"> -->
<!-- 					<h3>Atendimento</h3> -->
<!-- 					<ul>  -->
<!-- 						<li>Segunda das 12h às 18h</li> -->
<!-- 						<li>terça das 7h à 13h</li> -->
<!-- 						<li>quarta das 7h à 13h</li> -->
<!-- 						<li>quinta das 7h à 13h</li> -->
<!-- 						<li>sexta das 7h à 13h</li> -->
<!-- 					</ul>	 -->
<!-- 				</div> -->
				
<!-- 				<div class="col-md-4"> -->
<!-- 					<h3>Endereço</h3> -->
<!-- 					<p>Av. João Mosmann Filho, nº 143, 4° andar, Sala 41, Centro, Parobé.</p> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<hr> -->
<!-- 		</div> -->
		<!-- /container -->


</body>
</html>