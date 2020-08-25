<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
		<c:url value="/resources/dataTable" var="dataTablePath" />
		<link rel="stylesheet" href="${cssPath}/bootstrap.min.css" type="text/css" media="all"/>
		<link rel="stylesheet" href="${cssPath}/bootstrap-grid.min.css" type="text/css" media="all"/>
		<link rel="stylesheet" href="${cssPath}/bootstrap-theme.min.css" type="text/css" media="all"/>
		<link rel="stylesheet" href="${fontawesomePath}/css/all.css" type="text/css" media="all"/>
		<link rel="stylesheet" href="${dataTablePath}/datatables.min.css" type="text/css" media="all"/>
		<link rel="icon" href="${imgPath}/favicon.ico">
		<script type="text/javascript" src="${jsPath}/jquery-3.5.1.js"></script>
		<script type="text/javascript" src="${jsPath}/inputMask.js"></script>
		<script type="text/javascript" src="${jsPath}/bootstrap.min.js"></script>	
		<script type="text/javascript" src="${jsPath}/util.js"></script>		
		<script type="text/javascript" src="${dataTablePath}/datatables.min.js"></script>		
		<script type="text/javascript" src="${jsPath}/usuario.js"></script>  
	</head>

<body>

	<header>
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark py-md-1 ">
			<a class="navbar-brand" href="<c:url value='/logout'/>"  title="HelpDesk">HelpDesk</a>
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
		<div class="container wrapper" style="width: 600px; margin-top: 40px;">
			<h5 class="h5 mb-3 font-weight-normal">Atualizar senha de acesso</h5>
			<hr/>
			
			<p>
			<i>Forneça nova senha para acessar o sistema HelpDesk</i>
			</p>
			
			<hr/>
			<form:form action="${s:mvcUrl('UC#atualizarSenha').build() }" id="formAltualizarSenhaUsuarioId" name="formAltualizarSenhaUsuario" method="POST" >
						<div class="form-group row">
							<label for="nomeUsuario"  class="col-sm-2 col-form-label">Nome:</label>
							 <div class="col-sm-10"> 
								<input type="text" id="nomeUsuario" name="nome" readonly value="${usuario.nome }"
										   class="form-control-plaintext " />
							 </div>
						</div>
						<div class="form-group row">
							<label for="emailUsuario"  class="col-sm-2 col-form-label">Email:</label>
							 <div class="col-sm-10"> 
								<input type="email" id="emailUsuario" name="email" readonly value="${usuario.email }"
										   class="form-control-plaintext " />
							 </div>
						</div>
						
						<div class="form-group row"> 
							<label for="senhaUsuario" class="col-sm-2 col-form-label">Senha:</label> 
								<div class="input-group col-sm-8 " id="show_hide_password">
									<input type="password" id="senhaUsuario" name="senha" 
									       class="form-control form-control-sm"
				 						   placeholder="Senha" autofocus maxlength="30"/>
							      	<button type="button" class="btn btn-dark btn-sm" style="height: 32px !important;" onclick="showHidePassword()">
							    		<i class="fa fa-eye-slash" aria-hidden="true" ></i>
							    	</button>
								</div>
						</div>
						
						<hr/>
						<div class="row">
							<div class="form-group col-md-6" >
								<button type="button" id="btnEfetuarLogin" class="btn btn-success btn-sm" title="Efetuar Login" 
										onclick="window.location.href='<c:url value='/logout'/>'">
										<i class="fas fa-home"></i> Efetuar Login</button>
								<button type="button" id="btnAltualizarSenhaUsuario" class="btn btn-primary btn-sm" 
										title="Salvar Nova Senha" style="margin-left: 13px !important;"> 
										<i class="fas fa-save"></i> Salvar Senha</button>
							</div>
						</div>
				
				</form:form>
				<div id="respostaAltualizarSenhaUsuario" ></div> 
		</div>
	</main>

	
<script type="text/javascript">
	//Atualizar senha do usuario
	$(function() {
	   $('#btnAltualizarSenhaUsuario').click(function(e) {
		   
	      //Prevent default submission of form
	      e.preventDefault();
	      
	      $.post({
	    	 url : "${s:mvcUrl('UC#atualizarSenha').build() }" ,
	 	     data : $('form[name=formAltualizarSenhaUsuario]').serialize(),
	 	     beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
	            loading_show();  
	       	 },
	         success : function(res) {
	        	loading_hide();
	        	if(res.validated){
	               //Set response
	               msg('#respostaAltualizarSenhaUsuario','sucesso', res.message);
	               $('#btnAltualizarSenhaUsuario').hide();
				}else{
				   //Set error messages
				   var msg_err = '';
				   $.each(res.errorMessages,function(key,value){
				   		msg_err = msg_err + "<li>"+ value +"</li>";
	               });   
				   msg('#respostaAltualizarSenhaUsuario','erro', msg_err);
	            }
	         }	      
	      })
	   });
	});
	</script>

	<footer class="page-footer font-small pt-4" style="background-color: #e9ecef;"> 
		<!-- Copyright -->
		<div class="footer-copyright text-center" style="padding-bottom: 2rem;">
			&copy; Prefeitura Municipal de Parobé - 2020
		</div>
	</footer>
	
	<!-- Modal que apresenta mensagem e Carregando durante processamento-->
	<div class="modal" id="carregandoModal" tabindex="-1" role="dialog"
			aria-labelledby="carregandoModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-body">
				<div id="load" class="text-center">
					<div class="spinner-border text-center text-light" style="width: 3rem; height: 3rem;" role="status"></div>
				    <i style="color: #f8f9fa !important;">Carregando...</i>
				</div>			
			</div>
		</div>
	</div>
	
	</body>
</html>