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
		<h5 class="h5 mb-3 font-weight-normal">Atualizar Dados do Usuário</h5>
		<hr/>
		<form:form action="${s:mvcUrl('UC#atualizarDadosUsuario').build() }" id="formAlteraDadosUsuarioId" name="formAlteraDadosUsuario" method="POST" >
					<div class="row">
						<div class="form-group col">
							<label for="nomeUsuario" >Nome</label>
							<input type="text" id="nomeUsuario" name="nome" value="${usuario.nome }"
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
					
					<c:if test="${!usuario.operador }">
						<div class="row">
							<div class="form-group col">
								<label for="telefoneUsuario" >Telefone</label> 
								<input type="tel" id="telefoneUsuario" name="telefone" value="${usuario.telefone }"
									class="form-control form-control-sm" placeholder="Telefone" autofocus maxlength="15"
									onkeydown="javascript: fMasc( this, mTel );" onchange="javascript: fMasc( this, mTel );"
									oninput="javascript: fMasc( this, mTel );"/>
							</div>
							<div class="form-group col">
								<label for="ramalUsuario" >Ramal</label> 
								<input type="text" id="ramalUsuario" name="ramal" 
									class="form-control form-control-sm" value="${usuario.ramal }"
									placeholder="Ramal" autofocus maxlength="15"/>
							</div>
						</div>
					</c:if>
					
					<div class="row"> 
						<div class="form-group col"> 
							<label for="senhaUsuario" >Senha</label> 
							<div class="input-group" id="show_hide_password">
								<input type="password" id="senhaUsuario" name="senha" 
								       class="form-control form-control-sm"
			 						   placeholder="Senha" autofocus maxlength="30"/>
							      	<button type="button" class="btn btn-dark btn-sm" onclick="showHidePassword()">
							    		<i class="fa fa-eye-slash" aria-hidden="true"></i>
							    	</button>
							</div>
						</div>
					</div>
					
					
					<div class="row">
						<div class="form-group col-md-6" >
							<button type="button" class="btn btn-secondary btn-sm" title="Cancelar" 
									onclick="window.location.href='${s:mvcUrl('HC#home').build() }'">
									<i class="fas fa-arrow-left"></i> Voltar</button>
							<button type="button" id="btnAlterarUsuario" class="btn btn-primary btn-sm" title="Salvar">
								<i class="fas fa-save"></i> Salvar</button>
						</div>
					</div>
			
			</form:form>
			<div id="respostaAlteraDadosUsuario" ></div> 
	</div>	
</main>

	
<script type="text/javascript">
//Adicionar usuario
$(function() {
   /*  Submit form using Ajax */
   $('#btnAlterarUsuario').click(function(e) {
	   
      //Prevent default submission of form
      e.preventDefault();
      
      $.post({
    	 url : "${s:mvcUrl('UC#atualizarDadosUsuario').build() }", 
 	     data : $('form[name=formAlteraDadosUsuario]').serialize(),
 	     beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
            loading_show();  
       	 },
         success : function(res) {
        	 loading_hide();
            if(res.validated){
               //Set response
               msg('#respostaAlteraDadosUsuario','sucesso', res.message);           
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
               });   
               msg('#respostaAlteraDadosUsuario','erro', msg_err);           
            }
         }
      })
      
   });
});
</script>

</jsp:body>

</tags:pageTemplate>		