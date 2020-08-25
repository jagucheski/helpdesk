<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>

<tags:pageTemplate >

<jsp:attribute name="extraScripts">
	<c:url value="/resources/js" var="jsPath" />
	<script type="text/javascript" src="${jsPath}/solicitante.js"></script>   
</jsp:attribute>

<jsp:body>

	<main role="main" style="background-color: #f5f5f5;padding: 1rem;">
			<div class="container wrapper" >
					<h5 class="h5 mb-3 font-weight-normal">Vincular Setor</h5>
					<hr/>
					<div class="row">
						<div class="form-group col">
							<label for="dadosSolicitante" >Solicitante</label>
							<input type="text" id="dadosSolicitante" readonly="readonly" value="${solicitante.nome } - ${solicitante.email }"
								class="form-control form-control-sm"/>
	
						</div>
					</div>
					<hr/>
					
					<div class="row">
						<div class="form-group col-md-6" >
							<button type="button" class="btn btn-secondary btn-sm" title="Cancelar" 
								onclick="window.location.href='${s:mvcUrl('SC#solicitante').build() }'">
								<i class="fas fa-arrow-left"></i> Voltar</button>						
							<button type="button" id="btnVincularSetor" class="btn btn-success btn-sm" title="Vincular">
								<i class="fas fa-plus-circle"></i> Vincular</button>
						</div>
					</div>			
				
				<div id="respostaVincularSetor" ></div> 		
			</div>
	    
	    	<form:form name="solicitanteVincularSetorForm" method="POST" commandName="solicitante">
				<div class="container table-responsive-sm" style="margin-top: 10px !important; min-height:550px;" id="listaDeSetores">
				
				 	<div class="row" style="height: 20px !important;">
					 	<div class="col-auto mr-auto"> 
						  	<h5 class="h5 mb-3 font-weight-normal">Lista de Setores</h5>
						</div>				
					</div>
					<hr/>
					
					<input type="hidden" id="idSolicitante" name="email" value="${solicitante.email }"/>
					<input type="hidden" id="idSolicitante" name="nome" value="${solicitante.nome }"/>
					
					<table id=tableSolicitante class="table table-hover table-sm table-bordered" style="text-align:center;">
					  	<thead class="table-active">
							<tr>
								<th>#</th>
								<th>Código</th>
								<th>Nome</th>
								<th>Status</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${setores}" var="setor">
								<tr>
								    <c:if test="${setor.status == true}">
			 						    <td><form:radiobutton path="setorAtivo" value="${setor.id}" /></td>
								    </c:if>
								    <c:if test="${setor.status == false}">
			 						    <td><form:radiobutton path="setorAtivo" value="${setor.id}" disabled="true" /></td>
								    </c:if>
									<td title="${setor.id}">${setor.id}</td>
									<td title="${setor.nome}">${setor.nome}</td>
									<td title="${setor.status == true ? 'Ativo':'Inativo'}">${setor.status == true ? 'Ativo':'Inativo'}</td>
								</tr>
							</c:forEach>
					  	</tbody>
					</table>
				</div>
		</form:form>
	</main>	

<script type="text/javascript">

 //Ativar Subcategoria
$(function() {
   /*  Submit form using Ajax */
   $('#btnVincularSetor').click(function(e) {
	   
      //Prevent default submission of form
      e.preventDefault();
      
      $.post({
    	 url : "${s:mvcUrl('SC#vincularSetorSolicitante').build() }",
    	 data : $('form[name=solicitanteVincularSetorForm]').serialize(),
         success : function(res) {
         
            if(res.validated){
               //Set response
               msg('#respostaVincularSetor','sucesso', res.message);           
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
               });   
               msg('#respostaVincularSetor','erro', msg_err);           
            }
         }
      })
   });
});



</script>
	
</jsp:body>

</tags:pageTemplate>		