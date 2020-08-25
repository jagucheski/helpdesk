<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>

<tags:pageTemplate >

<jsp:attribute name="extraScripts">
	<c:url value="/resources/js" var="jsPath" />
	<script type="text/javascript" src="${jsPath}/chamadoOperador.js"></script>   
</jsp:attribute>

<jsp:body>

	<main role="main" style="background-color: #f5f5f5;padding: 1rem;">
			<div class="container wrapper" style="max-width: 700px;min-height: 800px;">
				<h5 class="h5 mb-3 font-weight-normal">Gerenciar/Chamados > Iniciar Atendimento</h5>
				<hr/>
				<form:form name="chamadoOperadorIniciarAtendimentoForm" method="POST" commandName="chamadoSolicitante">
						<div class="row">
						    <label class="col-sm-2 col-form-label">Código:</label>
						    <label class="col-sm-10" style="margin-top: 8px;">${chamadoSolicitante.id }</label>
						</div>
					
						<div class="row">
						    <label for="solicitante" class="col-sm-2 col-form-label">Solicitante:</label>
						    <label class="col-sm-10" style="margin-top: 8px;">${chamadoSolicitante.solicitante.nome} / ${chamadoSolicitante.solicitante.email}</label>
						</div>
					
						<div class="row">
						    <label for="dataCriacao" class="col-sm-2 col-form-label">Criação:</label>
						     <label class="col-sm-10" style="margin-top: 8px;"><fmt:formatDate pattern="dd/MM/yyyy HH:mm" value='${chamadoSolicitante.dataAbertura}' /></label>
						</div>
						
						<div class="row">
						    <label for="descricao" class="col-sm-2 col-form-label">Descrição:</label>
						    <div class="col-sm-10" style="margin-top: 8px;">
						      <form:textarea readonly="true" rows="6" class="form-control" id="descricao"  path="descricao"></form:textarea>
						    </div>
						</div>
						
						<div class="row" style="margin-top: 8px;">
			   				<label for="selectCategoria" class="col-sm-2 col-form-label">Assunto:</label> 
							<div class="col-sm-10" style="margin-top: 9px;">
			   					<form:select id="selectCategoria" path="categoriaSelect" class="form-control form-control-sm">
								    <form:option value="">Selecione...</form:option>
								    <form:options items="${categorias}" itemLabel="nome" itemValue="nome"/>
							    </form:select>
					   		</div>
						</div>	
						
						<div id="arrowSubCategoria" class="row" style="margin-left: 25px;">
			   				<div class="col-sm-2 col-form-label" ><i class='fas fa-long-arrow-alt-right'  style="margin-left: 80px;"></i></div> 
			   				<div id="divSubCategoria" class="col-sm-10" style="margin-top: 9px;">
			   					<form:select id="selectSubCategoria" path="subCategoriaSelect" class="form-control form-control-sm">
								    <form:option value="">Selecione...</form:option>
								    <form:options items="${subCategorias}" itemLabel="nome" itemValue="nome"/>
							    </form:select>
					   		</div>
						</div>	
					
						<div class="row">
			   				<label for="selectTipoCategoria" class="col-sm-2 col-form-label">Tipo:</label> 
							<div class="col-sm-10" style="margin-top: 9px;">
			   					<form:select id="selectTipoCategoria" path="tipoCategoriaSelect" class="form-control form-control-sm">
								    <form:option value="">Selecione...</form:option>
								    <form:options items="${tipoCategorias}" itemLabel="nome" itemValue="nome"/>
							    </form:select>
					   		</div>
						</div>	
						<div class="row">
			   				<label for="selectSetor" class="col-sm-2 col-form-label">Setor:</label> 
							<div class="col-sm-10" style="margin-top: 9px;">
			   					<form:select id="selectSetor" path="setorSelect" class="form-control form-control-sm">
								    <form:option value="">Selecione...</form:option>
								    <form:options items="${setores}" itemLabel="nome" itemValue="nome"/>
							    </form:select>
					   		</div>
						</div>	
						
						<div class="row"> 
							<div style="height: 32px !important;margin-right:14px;margin-left:14px;margin-top:14px;" class="input-group-text form-group col"> 
								<input type="checkbox" id="chkChamadoConcluido" name="chamadoConcluido">
								<i style="height: calc(1.5em + .5rem + 2px); padding: .25rem .5rem; font-size: .875rem;" >
									Chamado concluído ? (Inserir data/hora de início e fim do atendimento)</i>
							</div>
						</div>
					
						<div class="row" id="divDataInicioChamado" style="display: none; margin-top:10px;margin-left:30px;">
			   				<label for="dataInicio">Inicio:</label> 
						  	<input class="form-control form-control-sm" type="date" name="dataInicio" style="width: 135px;margin-left: 47px;">
			   			  	<input class="form-control form-control-sm" type="time" name="horaInicio" style="width: 85px;margin-left:10px;">
						</div>
						<div class="row" id="divDataFimChamado" style="display: none;margin-top:10px;margin-left:30px;">
			   				<label for="dataFim">Fim:</label> 
							<input class="form-control form-control-sm" type="date" name="dataFim" style="width: 135px;margin-left: 59px;">
				   			<input class="form-control form-control-sm" type="time" name="horaFim" style="width: 85px;margin-left:10px;">
				   			
						</div>
						
						
						<form:hidden path="id" id="id" />
					<hr/>
					<div class="row">
						<div class="form-group col-md-6" >
							<button type="button" class="btn btn-secondary btn-sm" title="Voltar" 
								onclick="window.location.href='${s:mvcUrl('COC#chamadoOperador').build() }'">
								<i class="fas fa-arrow-left"></i> Voltar</button>						
							<button type="button" id="btnIniciarAtendimento" class="btn btn-primary btn-sm" title="Iniciar Atendimento">
								<i class="fas fa-user-cog"></i> Iniciar Atendimento</button>
						</div>
					</div>
				</form:form>
				<div id="respostaChamadoIniciarAtendimento" ></div> 		
			</div>
	   
	</main>	

<script type="text/javascript">


//carregar sub-categoria
$(function() {
 /*  Submit form using Ajax */
 $('#selectCategoria').change(function(e) {
	   
    //Prevent default submission of form
    e.preventDefault();
    
    var selectBox = document.getElementById("selectCategoria");
    var idCategoria = selectBox.options[selectBox.selectedIndex].value;
    var nomeCategoria = selectBox.options[selectBox.selectedIndex].text;
	  
    if(nomeCategoria=='Selecione...'){
   	  $('#divSubCategoria').empty();
  	  $("#arrowSubCategoria").hide()
    }else{
  	  $.ajax({
	    	 url : "${s:mvcUrl('CSC#carregaSubCategoria').build() }", 
	    	 data : {val:nomeCategoria},
	    	
	 		 beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
	             loading_show();  
	       	 },
	         success : function(res) {
	        	loading_hide();
	            if(res.validated){
	            	 $("#arrowSubCategoria").show()
	            	 $('#divSubCategoria').empty();
	            	 var s = $("<select id='selectSubCategoria' name='subCategoriaSelect' class='form-control form-control-sm'>  <option value=''>Selecione...</option>");
	            	 $.each(res.subCategorias,function(key,value){
					   	$("<option value'"+ value +" name='subCategoria'>"+ value +" </option>").appendTo(s);
		             });
	            	 $("</select>").appendTo(s);
	            	 s.appendTo("#divSubCategoria");
				}else{
				   //Set error messages
				   var msg_err = '';
				   $.each(res.errorMessages,function(key,value){
				   		msg_err = msg_err + "<li>"+ value +"</li>";
	               });   
	               msg('#respostaChamadoIniciarAtendimento','erro', msg_err);           
	            }
	         }
	      })
	    }
	});
});


//Iniciar Atendimento Chamado
$(function() {
 /*  Submit form using Ajax */
 $('#btnIniciarAtendimento').click(function(e) {
	   
    //Prevent default submission of form
    e.preventDefault();
    
    $.post({
  	 url : "${s:mvcUrl('COC#iniciarAtendimentoChamado').build() }", 
	     data : $('form[name=chamadoOperadorIniciarAtendimentoForm]').serialize(),
		 beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
           loading_show();  
     	 },
       success : function(res) {
      	loading_hide();
          if(res.validated){
             //Set response
             $('#btnIniciarAtendimento').hide();
             msg('#respostaChamadoIniciarAtendimento','sucesso', res.message);    
             
             window.setTimeout(function() {
	             window.location.href = "${s:mvcUrl('COC#chamadoOperador').build() }";
     		}, 3000);
             
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
             });   
             msg('#respostaChamadoIniciarAtendimento','erro', msg_err);           
          }
       }
    })
 });
});

//funcao para mostrar campos de inicio e encerramento do chamado
$(function () {
    $("#chkChamadoConcluido").click(function () {
        if ($(this).is(":checked")) {
            $("#divDataInicioChamado").show();
            $("#divDataFimChamado").show();
        } else {
        	$("#divDataInicioChamado").hide();
            $("#divDataFimChamado").hide();
        }
    });
});


</script>
	
</jsp:body>

</tags:pageTemplate>		