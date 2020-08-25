<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>

<tags:pageTemplate >

<jsp:attribute name="extraScripts"> 
</jsp:attribute>

<jsp:body>

	<main role="main" style="background-color: #f5f5f5;padding: 1rem;">
		<div class="container wrapper" style="max-width: 900px;min-height: 800px;">	
			<h5 class="h5 mb-3 font-weight-normal">Chamado > Mensagens</h5>
			<hr/>
			<div style="width:100%;">
				 <c:choose>
				 	<c:when test="${chamadoSolicitante.status eq 'Concluído'}">
				 		<div style="font-size: .8rem;background-color: #5bc0de  !important;padding: 10px;border-radius: .25rem;">
					 		<label><i class="fas fa-check"></i> Chamado Concluído! Obs.: Este chamado não permite novas mensagens.</label>
				 		</div>
				 		<br/>				 	
				 	</c:when>
				 	<c:when test="${chamadoSolicitante.status eq 'Aguardando terceiros'}">
				 		<div style="font-size: .8rem;background-color: #ffc107  !important;padding: 10px;border-radius: .25rem;">
					 		<label><i class="fas fa-check"></i> Chamado aguardando retorno de terceiros.</label>
				 		</div>
				 		<br/>				 	
				 	</c:when>
				 	<c:when test="${chamadoSolicitante.status eq 'Em atendimento' or chamadoSolicitante.status eq 'Aguardando retorno do solicitante'}">
					 	 	<form:form id="mensagemCadForm" name="mensagemCadForm" commandName="mensagem">
								<div class="form-group row" style="margin-left: 5%;">
									<div class="col-8">
										<form:textarea class="form-control form-control-sm" id="descricao" path="descricao"
										  rows="5" maxlength="255" placeholder="Insira uma mensagem" autofocus="autofocus"/>
										
					   				</div>
									<div class="form-group col-4" style="margin-top: 20px;">
										<div class="form-group">
											<button type="button" class="btn btn-info btn-sm" onclick="clear_form('#mensagemCadForm')" title="Limpar">
												<i class="fas fa-eraser"></i> Limpar</button>										
						   				</div>
										<div class="form-group">
											<button type="button" id="btnAdicionarMensagem" class="btn btn-success btn-sm" title="Adicionar Mensagem">
												<i class="fas fa-plus"></i> Adicionar</button>
						   				</div>
					   				</div>									
								</div>
							
								<div id="respostMensagemCad" ></div> 	
								<form:input type="hidden" path="chamado.id" id="inputIdChamado"/>	
							</form:form>						
				 	</c:when>
				</c:choose>
				<div style="width:100%;max-height:650px; overflow-y: scroll; border: 1px solid #ced4da; border-radius: .25rem; padding: 0.75rem;">				
					<c:forEach items="${mensagens}" var="mensagem">
						 <c:choose>
						 	<c:when test="${mensagem.usuario.operador eq true}">
								<div style="background-color:white; border: 1px solid #ced4da; border-radius: .2rem; padding: 0.75rem;font-size: .8rem;width:50%;margin-left: 50%;" >
									<div> 
						        		<i class="fas fa-headset" style="font-size: 1.4rem;"></i> ${mensagem.usuario.nome} - <fmt:formatDate pattern="dd/MM/yyyy HH:mm" value="${mensagem.data}" />
						        		<hr/>
									</div>
									<textarea class="form-control form-control-sm" readonly="readonly" rows="4">${mensagem.descricao}</textarea>
								</div>
								<br/>
							 </c:when>
							 
						 	 <c:otherwise>
								<div style="background-color:white; border: 1px solid #ced4da; border-radius: .2rem; padding: 0.75rem;font-size: .8rem;width:50%;" >
									<div> 
						        		<i class="fas fa-user-circle" style="font-size: 1.4rem;"></i> ${mensagem.usuario.nome} - <fmt:formatDate pattern="dd/MM/yyyy HH:mm" value="${mensagem.data}" /> 
						        		<hr/>
									</div>
									<textarea class="form-control form-control-sm" readonly="readonly" rows="4">${mensagem.descricao}</textarea>
								</div>					            
								<br/>
					         </c:otherwise>			 
						</c:choose>					
					</c:forEach>
					<div style="background-color:white; border: 1px solid #ced4da; border-radius: .2rem; padding: 0.75rem;font-size: .8rem;width:50%;" >
						<div> 
			        		<i class="fas fa-user-circle" style="font-size: 1.4rem;"></i>  ${chamadoSolicitante.solicitante.nome}- <fmt:formatDate pattern='dd/MM/yyyy HH:mm' value='${chamadoSolicitante.dataAbertura}' />
			        		<hr/>
						</div>
						<p>${chamadoSolicitante.descricao}</p>	
						Assunto: ${chamadoSolicitante.categoria.nome}/${chamadoSolicitante.subCategoria.nome}<br/>
						Tipo: ${chamadoSolicitante.tipoCategoria.nome}<br/>
						Setor: ${chamadoSolicitante.setor.nome}
					</div>
				</div>	
			</div>	
			<br/>
			<div class="row">
				<div class="form-group col-md-6" >
					<button type="button" class="btn btn-secondary btn-sm" title="Voltar" 
					 onclick="window.location.href='${s:mvcUrl('CSC#chamadoSolicitante').build() }'">
					 	<i class="fas fa-arrow-left"></i> Voltar
					 </button>
				</div>
			</div>	
		</div>
			
					
		
	   
	</main>	

<script type="text/javascript">

//Iniciar Atendimento Chamado
$(function() {
 /*  Submit form using Ajax */
 $('#btnAdicionarMensagem').click(function(e) {
	   
    //Prevent default submission of form
    e.preventDefault();
    
    $.post({
  	 url : "${s:mvcUrl('CSC#adicionarMensagem').build() }", 
	     data : $('form[name=mensagemCadForm]').serialize(),
		 beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
           loading_show();  
     	 },
       success : function(res) {
      	loading_hide();
          if(res.validated){
             //Set response
             clear_form('#mensagemCadForm');
             msg('#respostMensagemCad','sucesso', res.message);    
             
             window.setTimeout(function() {
            	 location.reload();
     		}, 3500);
             
          }else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
             });   
             msg('#respostMensagemCad','erro', msg_err);           
          }
       }
    })
 });
});

</script>
	
</jsp:body>

</tags:pageTemplate>		