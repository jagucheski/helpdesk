<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

	<!-- Inicio Modal Excluir chamado-->
	<div class="modal fade" id="chamadoExcluirModal" tabindex="-1" role="dialog"
		aria-labelledby="chamadoSolicitanteExcluirModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="chamadoExcluirForm" name="chamadoExcluirForm" method="POST">
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h6 class="modal-title" id="chamadoModalLabel">Excluir Chamado</h6>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body"> 
						<h6 class='modal-title'>Deseja realmente excluir este chamado ? </h6>
						<div id="divExcluirChamado"></div> 
						<div class="form-group col">
							<textarea class="form-control form-control-sm" id="descricaoExcluirChamado" 
									  rows="5" readonly="readonly">
							</textarea>
		   				</div>
						<input type="hidden" name="id" id="inputIdChamado" value=""/>					
						<input type="hidden" name="solicitante.email" id="inputEmail" value=""/>
						<div id="alertaExcluirChamado"></div>					
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-secondary btn-sm" title="Cancelar" data-dismiss="modal">
							<i class="fas fa-times"></i> Cancelar</button>
						<button type="button" id="btnExcluirChamado" class="btn btn-danger btn-sm" title="Sim, excluir chamado!">
							<i class="fas fa-trash"></i> Sim, excluir chamado!</button>	
					</div>
				</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Excluir chamado-->
	
	<!-- Inicio Modal Visualizar chamado-->
	<div class="modal fade" id="chamadoVisualizarModal" tabindex="-1" role="dialog"
		aria-labelledby="chamadoVisualizarModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="chamadoVisualizarForm" name="chamadoVisualizarForm" method="POST">
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h6 class="modal-title" id="chamadoVisualizarModalLabel">Visualizar Chamado</h6>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					
					<div class="modal-body " style="margin-left: 20px;">
					
							<div class="row">
								<label class="col-form-label col-form-label-sm">Código: </label> 
							    <div id="idVisualizarChamado" style="margin-left:35px;"></div>
							</div>
							<div class="row">
								<label class="col-form-label col-form-label-sm">Criação: </label> 
							    <div id="dataAberturaVisualizarChamado" style="margin-left:35px;"></div>
							</div>
							<hr/>
							<div class="row">
								<label class="col-form-label col-form-label-sm">Solicitante: </label> 
							    <div id="solicitanteVisualizarChamado" style="margin-left:18px;"></div>
							</div>
							<div class="row">
								<label class="col-form-label col-form-label-sm">Setor: </label> 
							    <div id="setorVisualizarChamado" style="margin-left:48px;"></div>
							</div>
							<hr/>
							<div class="row">
								<label class="col-form-label col-form-label-sm">Assunto: </label> 
							    <div id="assuntoVisualizarChamado" style="margin-left:30px;"></div>
							</div>
							<div class="row">
								<label class="col-form-label col-form-label-sm">Tipo: </label> 
							    <div id="tipoCategoriaVisualizarChamado" style="margin-left:54px;"></div>
							</div>
							<div class="row">
								<div>
									<label for="descricaoVisualizar" class="col-form-label col-form-label-sm">Descrição:</label> 
								</div>
								<div class="form-group col" style="margin-top:10px;">
									<textarea class="form-control form-control-sm" id="descricaoVisualizarChamado" name="descricao" rows="6" readonly="readonly" ></textarea>
				   				</div>
							</div>
							<div id="alertaVisualizarChamado"></div> 					
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-secondary btn-sm" title="Fechar" onclick="clear_form('#chamadoVisualizarForm')" data-dismiss="modal">
							<i class="fas fa-times"></i> Fechar</button>
					</div>
			</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Visualizar chamado -->
	
	<!-- Inicio Modal Finalizar chamado-->
	<div class="modal fade" id="chamadoFinalizarModal" tabindex="-1" role="dialog"
		aria-labelledby="chamadoSolicitanteFinalizarModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="chamadoFinalizarForm" name="chamadoFinalizarForm" method="POST">
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h6 class="modal-title" id="chamadoModalLabel">Finalizar Chamado</h6>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body"> 
						<h6 class='modal-title'>Deseja finalizar este chamado ? </h6>
						<hr/>
						<div id="divDadosChamado"></div> 
						<hr/>

		   				<div class="form-group" >
		   					<label for="descricao">Mensagem:</label>
							<textarea class="form-control form-control-sm" id="descricao" name="descricao" rows="6" maxlength="255"
									placeholder="Insira uma mensagem para finalizar o chamado" autofocus="autofocus"></textarea>
			   			</div>
		   				
						<input type="hidden" name="id" id="inputIdChamadoFinalizar" value=""/>					
						<input type="hidden" name="solicitante.email" id="inputEmailFinalizar" value=""/>
						<div id="alertaFinalizarChamado"></div>					
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-secondary btn-sm" title="Cancelar" data-dismiss="modal">
							<i class="fas fa-times"></i> Cancelar</button>
						<button type="button" id="btnFinalizarChamado" class="btn btn-primary btn-sm" title="Sim, finalizar chamado!">
							<i class="fas fa-save"></i> Sim, finalizar chamado!</button>	
					</div>
				</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Excluir chamado-->
	
	<!-- Inicio Modal Novo Chamado Solicitante-->
	<div class="modal fade" id="chamadoSolicitanteModal" tabindex="-1" role="dialog"
		aria-labelledby="chamadoSolicitanteModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document" style="max-width:600px;">
			<form:form id="chamadoSolicitanteCadForm" name="chamadoSolicitanteCadForm" method="POST" commandName="chamadoSolicitante">
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h6 class="modal-title" id="chamadoModalLabel">Novo Chamado do Solicitante</h6>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body" style="margin-left: 20px;">
						<div class="row" >
			   				<div>
								<label for="tipoCategoria">Solicitante:</label> 
							</div>
			   				<div class="form-group col">
								<form:input class="form-control form-control-sm" type="text" id="solicitanteNome" path="solicitanteSelect"
								placeholder="Digite o nome do usuário"/>
				   			</div>
						</div>
							
						<div class="row">
							<div>
								<label for="categoria">Assunto:</label> 
							</div>
							<div class="form-group col" style="margin-left: 11px;">
								<form:select id="selectCategoria" path="categoriaSelect" class="form-control form-control-sm">
								   	<form:option value="">Selecione...</form:option>
								    <form:options items="${categorias}" itemLabel="nome" itemValue="nome"/>
							    </form:select>
			   				</div>
						</div>
			   			
			   			<div id="arrowSubCategoria" class="row" style="margin-left: 80px; display:none;">
			   				<div><i class='fas fa-long-arrow-alt-right'></i></div>
			   				<div id="divSubCategoria" class="form-group col">
					   		</div>
						</div>	
							
			   			<div class="row" >
			   				<div>
								<label for="tipoCategoria">Tipo:</label> 
							</div>
			   				<div class="form-group col" style="margin-left: 37px;">
			   					<form:select id="selectTipoCategoria" path="tipoCategoriaSelect" class="form-control form-control-sm">
								    <form:option value="">Selecione...</form:option>
								    <form:options items="${tipoCategorias}" itemLabel="nome" itemValue="nome"/>
							    </form:select>
					   		</div>
						</div>		
						
						<div class="row">
							<div>
								<label for="descricao">Descrição:</label> 
							</div>
							<div class="form-group col">
								<form:textarea class="form-control form-control-sm" id="descricao" path="descricao" rows="6" maxlength="255"
									placeholder="Insira a descrição chamado" autofocus="autofocus"></form:textarea>
			   				</div>
						</div>
						<div class="row">
							<div>
			   					<label for="selectSetor">Setor:</label>
			   				</div>	 
							<div class="form-group col" style="margin-left: 30px;">
			   					<form:select id="selectSetor" path="setorSelect" class="form-control form-control-sm">
								    <form:option value="">Selecione...</form:option>
								    <form:options items="${setores}" itemLabel="nome" itemValue="nome"/>
							    </form:select>
					   		</div>
						</div>	
						<div class="row"> 
							<div style="height: 32px !important;margin-right:14px;" class="input-group-text form-group col"> 
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
						<br/>
						<div id="alertaCarregaSubCategoria"></div>	
						<div id="alertaCadChamadoSolicitante"></div>	
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-info btn-sm" title="Limpar" onclick="clear_formChamadoCad('#chamadoSolicitanteCadForm')" >
							<i class="fas fa-eraser"></i> Limpar</button>
						<button type="button" class="btn btn-secondary btn-sm" title="Fechar" onclick="clear_formChamadoCad('#chamadoSolicitanteCadForm')" data-dismiss="modal">
							<i class="fas fa-times"></i> Fechar</button>
						<button type="button" id="btnSalvarChamadoSolicitante" class="btn btn-primary btn-sm" title="Salvar">
							<i class="fas fa-save"></i> Salvar</button>
					</div>
			</div>
			</form:form>
		</div>
	</div>
		<!-- Fim Modal Novo chamado solicitante-->
	
	
	
<script type="text/javascript">

//Excluir chamado 
$(function() {
	$('#btnExcluirChamado').click(function(e) {
	   e.preventDefault();
	   $.post({
	 	 url : "${s:mvcUrl('COC#excluir').build() }", 
		     data : $('form[name=chamadoExcluirForm]').serialize(),
		     beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
	         loading_show();  
	   	 },
	      success : function(res) {
	     	loading_hide();
	         if(res.validated){
	            //Set responsealertaExcluirChamadoSolicitante
	            $('#chamadoExcluirModal').modal('hide');
	            msg('#resposta','sucesso', res.message);           
				}else{
				   //Set error messages
				   var msg_err = '';
				   $.each(res.errorMessages,function(key,value){
				   		msg_err = msg_err + "<li>"+ value +"</li>";
	               });  
				   msg('#alertaExcluirChamado','erro', msg_err);   
	         }
	      }
	   })
	});
});

/**
*carregar modal excluir chamado solicitante
**/       
function openModalExcluirChamado(idChamado, email, nomeSolicitante, dataAberturaChamado) {
	$.ajax({
   	 url : "${s:mvcUrl('COC#carregaDescricaoChamado').build() }", 
   	 data : {val:idChamado},
   	
		 beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
            loading_show();
      	 },
        success : function(res) {
       	loading_hide();
           if(res.validated){
	       	    $('#inputIdChamado').val(idChamado);
	       		$('#inputEmail').val(email);
	       		$('#divExcluirChamado').empty();
	       		var resposta = "<ul>"
	       				+ "<li>Código: " + idChamado +"</li>"
	       				+ "<li>Solicitante: " + nomeSolicitante +" / " + email +"</li>"
	       		    	+ "<li>Criação: " + dataAberturaChamado +"</li>"
	       				+ "<li>Descrição:</li>"
	       			+ "</ul>";
	       		$("#descricaoExcluirChamado").val(res.descricaoChamado);	       			
	       		$('#divExcluirChamado').append(resposta);
        	}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
              });   
              msg('#alertaExcluirChamado','erro', msg_err);           
           }
        }
     })
}

/**
*carregar modal visualizar chamado 
**/       

function openModalVisualizarChamado(idChamado, dataAbertura, tipoCategoria, categoriaNome, subCategoriaNome, setorNome, solicitante) {
	$.ajax({
    	 url : "${s:mvcUrl('COC#carregaDescricaoChamado').build() }", 
    	 data : {val:idChamado},
    	
 		 beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
             loading_show();
       	 },
         success : function(res) {
        	loading_hide();
            if(res.validated){
            	$('#idVisualizarChamado').empty();
            	$('#dataAberturaVisualizarChamado').empty();
            	$('#tipoCategoriaVisualizarChamado').empty();
            	$('#assuntoVisualizarChamado').empty();
            	$('#setorVisualizarChamado').empty();
            	$('#solicitanteVisualizarChamado').empty();
            	
            	$("#idVisualizarChamado").append("<label class='col-form-label col-form-label-sm'> "+idChamado+"</label>");
            	$("#dataAberturaVisualizarChamado").append("<label class='col-form-label col-form-label-sm'> "+dataAbertura+"</label>");
            	$("#tipoCategoriaVisualizarChamado").append("<label class='col-form-label col-form-label-sm'> "+tipoCategoria+"</label>");
            	$("#assuntoVisualizarChamado").append("<label class='col-form-label col-form-label-sm'> "+categoriaNome + " - " + subCategoriaNome+"</label>");
            	$("#setorVisualizarChamado").append("<label class='col-form-label col-form-label-sm'> "+setorNome+"</label>");
            	$("#solicitanteVisualizarChamado").append("<label class='col-form-label col-form-label-sm'> "+solicitante+"</label>");
            	$("#descricaoVisualizarChamado").val(res.descricaoChamado);

            	$('#chamadoVisualizarModal').modal({backdrop: 'static', keyboard: false})  	
            	$('#chamadoVisualizarModal').modal('show');
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
               });   
               msg('#alertaVisualizarChamado','erro', msg_err);           
            }
         }
     })
}


/**
*carregar modal finalizar chamado
**/  
function openModalFinalizarChamado(idChamado, email, nomeSolicitante, dataAberturaChamado, assuntoChamado) {
	$('#inputIdChamadoFinalizar').val(idChamado);
	$('#inputEmailFinalizar').val(email);
	$('#divDadosChamado').empty();
	var resposta = "<ul>"
		+ "<li>Código: " + idChamado +"</li>"
		+ "<li>Solicitante: " + nomeSolicitante +" / " + email +"</li>"
    	+ "<li>Criação: " + dataAberturaChamado +"</li>"		
    	+ "<li>Assunto: " + assuntoChamado +"</li>"		
		+ "</ul>";
	$('#divDadosChamado').append(resposta);
}

//finalizar chamado 
$(function() {
	$('#btnFinalizarChamado').click(function(e) {
	   e.preventDefault();
	   $.post({
	 	 url : "${s:mvcUrl('COC#finalizarAtendimentoChamado').build() }", 
		     data : $('form[name=chamadoFinalizarForm]').serialize(),
		     beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
	         loading_show();  
	   	 },
	      success : function(res) {
	     	loading_hide();
	         if(res.validated){
	            //Set responsealertaExcluirChamadoSolicitante
	            $('#chamadoFinalizarModal').modal('hide');
	            msg('#resposta','sucesso', res.message); 
	        
	            window.setTimeout(function() {
	            	 window.location.href = "${s:mvcUrl('COC#chamadoOperador').build() }";
	     		}, 3500);
	            
			}else{
				   //Set error messages
				   var msg_err = '';
				   $.each(res.errorMessages,function(key,value){
				   		msg_err = msg_err + "<li>"+ value +"</li>";
	               });  
				   msg('#alertaFinalizarChamado','erro', msg_err);   
	         }
	      }
	   })
	});
});

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
	    	 url : "${s:mvcUrl('COC#carregaSubCategoria').build() }", 
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
	               msg('#alertaCarregaSubCategoria','erro', msg_err);           
	            }
	         }
	      })
      }
   });
});


//Adicionar Chamado Solicitante
$(function() {
 /*  Submit form using Ajax */
 $('#btnSalvarChamadoSolicitante').click(function(e) {
	   
    //Prevent default submission of form
    e.preventDefault();
    
    $.post({
  	 url : "${s:mvcUrl('COC#adicionarChamadoSolicitante').build() }", 
	     data : $('form[name=chamadoSolicitanteCadForm]').serialize(),
		 beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
           loading_show();  
     	 },
       success : function(res) {
      	loading_hide();
          if(res.validated){
             //Set response
             clear_formChamadoCad('#chamadoSolicitanteCadForm');
             $('#chamadoSolicitanteModal').modal('hide');
             msg('#resposta','sucesso', res.message);   
             
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
             });   
             msg('#alertaCadChamadoSolicitante','erro', msg_err);           
          }
       }
    })
 });
});

$(document).ready(function() {
	$( "#solicitanteNome" ).autocomplete({
		source: "${s:mvcUrl('COC#searchSolicitanteAutocomplete').build() }"
	});
}); 

function clear_formChamadoCad(ele) {
	$('#divSubCategoria').empty();
	$("#arrowSubCategoria").hide();
	$("#divDataInicioChamado").hide();
    $("#divDataFimChamado").hide();
	$(ele).trigger("reset");
}

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


//funcao para não efetuar requisicao via post pelo formulario
$(function() {
   $('#chamadoSolicitanteModal').submit(function(event){
       return checkFocus();
    });
 });

function checkFocus() {
 if ($('#solicitanteNome').is(':focus')) {
    return false;
 }
 return true;
}


</script>