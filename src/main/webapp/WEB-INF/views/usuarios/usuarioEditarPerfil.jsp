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

<main role="main" style="background-color: #f5f5f5;padding: 1rem; min-height: 800px; ">
	<div class="container wrapper" style="width: 600px; ">
		<h5 class="h5 mb-3 font-weight-normal">Editar Perfil do Usuário</h5>
		<hr/>
		<form:form action="${s:mvcUrl('UC#editarPerfilUsuario').build() }" id="formEditarPerfilUsuarioId" name="formEditarPerfilUsuario" method="POST" modelAttribute="usuario">
		
					<div class="row">
						<div class="form-group col">
							<label for="nomeUsuario" >Nome</label>
							<input type="text" id="nomeUsuario" name="nome" readonly value="${usuario.nome }"
								   class="form-control form-control-sm" autofocus/>
						</div>
					</div>
					<div class="row">
						<div class="form-group col">
							<label for="emailUsuario" >Email</label> 
							<input type="email" id="emailUsuario" name="email" readonly value="${usuario.email }"
								class="form-control form-control-sm"  autofocus/>
						</div>
					</div>
					
					<hr/>
					<div class="row">
						<div class="form-group col">
							<label>Perfil</label>
							<form:checkboxes path="perfis" items="${roleList}" element="div"  />
						</div>	
					</div>
					
					
					<div class="input-group-text" style="height: 26px !important;">
						<i style="height: calc(1.5em + .5rem + 2px); padding: .25rem .5rem; font-size: .875rem;" >
							*Obs.: O perfil "Usuário" é perfil padrão, todo usuário deverá possui.</i>					
					</div>
					
					
					
					
					
					<hr/>
					<div class="row">
						<div class="form-group col-md-6" >
							<button type="button" class="btn btn-secondary btn-sm" title="Cancelar" 
									onclick="window.location.href='${s:mvcUrl('UC#usuario').build() }'">
									<i class="fas fa-arrow-left"></i> Voltar</button>
							<button type="button" id="btnEditarPerfilUsuario" class="btn btn-primary btn-sm" title="Salvar">
								<i class="fas fa-save"></i> Salvar</button>
						</div>
					</div>
			
			</form:form>
			<div id="respostaEditarPerfilUsuario" ></div> 
	</div>	
</main>
<script type="text/javascript">
//Adicionar usuario
$(function() {
   /*  Submit form using Ajax */
   $('#btnEditarPerfilUsuario').click(function(e) {
	   
      //Prevent default submission of form
      e.preventDefault();
      
      $.post({
    	 url : "${s:mvcUrl('UC#editarPerfilUsuario').build() }", 
 	     data : $('form[name=formEditarPerfilUsuario]').serialize(),
         success : function(res) {
         
            if(res.validated){
               //Set response
               msg('#respostaEditarPerfilUsuario','sucesso', res.message);           
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
               });   
               msg('#respostaEditarPerfilUsuario','erro', msg_err);           
            }
         }
      })
   });
});
</script>

</jsp:body>

</tags:pageTemplate>		