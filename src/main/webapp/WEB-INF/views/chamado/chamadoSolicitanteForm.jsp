<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

	<!-- Inicio Modal Novo Chamado-->
	<div class="modal draggable" id="chamadoModal" tabindex="-1" role="dialog"
		aria-labelledby="chamadoModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="chamadoCadForm" name="chamadoForm" method="POST" commandName="chamadoSolicitante">
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h6 class="modal-title" id="chamadoModalLabel">Novo Chamado</h6>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body" style="margin-left: 20px;">
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
									placeholder="Insira a descrição do seu chamado" autofocus="autofocus"></form:textarea>
			   				</div>
						</div>
						
						<div id="alertaCarregaSubCategoria"></div>	
						<div id="alertaCadChamado"></div>	
							
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-info btn-sm" title="Limpar" onclick="clear_formChamadoCad('#chamadoCadForm')" >
							<i class="fas fa-eraser"></i> Limpar</button>
						<button type="button" class="btn btn-secondary btn-sm" title="Fechar" onclick="clear_formChamadoCad('#chamadoCadForm')" data-dismiss="modal">
							<i class="fas fa-times"></i> Fechar</button>
						<button type="button" id="btnSalvarChamado" class="btn btn-primary btn-sm" title="Salvar">
							<i class="fas fa-save"></i> Salvar</button>
					</div>
				
			</div>
			</form:form>
		</div>
	</div>
		<!-- Fim Modal Novo chamado solicitante-->
		
	<!-- Inicio Modal Excluir chamado solicitante-->
	<div class="modal fade" id="chamadoSolicitanteExcluirModal" tabindex="-1" role="dialog"
		aria-labelledby="chamadoSolicitanteExcluirModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="chamadoSolicitanteExcluirForm" name="chamadoSolicitanteExcluirForm" method="POST">
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h6 class="modal-title" id="chamadoSolicitanteModalLabel">Excluir Chamado</h6>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body"> 
						<div id="divExcluirChamadoSolicitante"></div> 
						<div class="form-group col">
							<textarea class="form-control form-control-sm" id="descricaoExcluirChamadoSolicitante" 
									  rows="5" readonly="readonly">
							</textarea>
		   				</div>
						<input type="hidden" name="id" id="inputIdChamadoSolicitante" value=""/>					
						<input type="hidden" name="solicitante.email" id="inputEmailSolicitante" value=""/>
						<div id="alertaExcluirChamadoSolicitante"></div>					
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-secondary btn-sm" title="Cancelar" data-dismiss="modal">
							<i class="fas fa-times"></i> Cancelar</button>
						<button type="button" id="btnExcluirChamadoSolicitante" class="btn btn-danger btn-sm" title="Sim, excluir chamado!">
							<i class="fas fa-trash"></i> Sim, excluir chamado!</button>	
					</div>
				</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Excluir chamado solicitante-->
	
	
	<!-- Inicio Modal Editar chamado solicitante-->
	<div class="modal fade" id="chamadoSolicitanteEditarModal" tabindex="-1" role="dialog"
		aria-labelledby="chamadoSolicitanteEditarModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="chamadoSolicitanteEditarForm" name="chamadoSolicitanteEditarForm" method="POST">
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h6 class="modal-title" id="chamadoSolicitanteEditarModalLabel">Editar Chamado</h6>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					
					<div class="modal-body " style="margin-left: 20px;">
							<div class="form-group row">
						    	<label for="idEditChamadoSolicitante" class="col-form-label col-form-label-sm">Código:</label>
						   		<div class="col-md-6" style="margin-left: 12px;  max-width: 160px;">
								  <input type="text" id="idEditChamadoSolicitante" name="id" readonly="readonly"
										class="form-control form-control-sm"/>
						    	</div>
							</div>
							<div class="form-group row">
								<label for="dataAberturaEditChamadoSolicitante" class="col-form-label col-form-label-sm">Criação:</label>
						   		<div class="col-md-6" style="margin-left: 12px; max-width: 160px;">
								  <input type="text" id="dataAberturaEditChamadoSolicitante" readonly="readonly" class="form-control form-control-sm"/>
						    	</div>
							</div>
							<div class="row">
								<div>
						    		<label for="assuntoEditChamadoSolicitante" class="col-form-label col-form-label-sm">Assunto:</label>
						    	</div>
						   		<div class="form-group col" style="margin-left: 9px;">
								  <input type="text" id="assuntoEditChamadoSolicitante" readonly="readonly" class="form-control form-control-sm"/>
						    	</div>
							</div>
							<div class="row">
								<div>
									<label for="tipoCategoriaEditChamadoSolicitante" class="col-form-label col-form-label-sm">Tipo:</label>
								</div>
						   		<div class="form-group col" style="margin-left: 33px;">
								  <input type="text" id="tipoCategoriaEditChamadoSolicitante" readonly="readonly" class="form-control form-control-sm"/>
						    	</div>
							</div>
							<div class="row">
								<div>
									<label for="descricaoEdit" class="col-form-label col-form-label-sm">Descrição:</label> 
								</div>
								<div class="form-group col">
									<textarea class="form-control form-control-sm" id="descricaoEditChamadoSolicitante" name="descricao" rows="6" maxlength="255"
										placeholder="Insira a descrição do seu chamado" autofocus="autofocus"></textarea>
				   				</div>
							</div>
							<div id="alertaEditarChamadoSolicitante"></div> 					
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-info btn-sm" title="Limpar" onclick="clear_field('#descricaoEditChamadoSolicitante')" >
							<i class="fas fa-eraser"></i> Limpar</button>
						<button type="button" class="btn btn-secondary btn-sm" title="Fechar" onclick="clear_form('#chamadoSolicitanteEditarForm')" data-dismiss="modal">
							<i class="fas fa-times"></i> Fechar</button>
						<button type="button" id="btnSalvarEditarChamadoSolicitante" class="btn btn-primary btn-sm" title="Salvar">
							<i class="fas fa-save"></i> Salvar</button>
					</div>
			</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Editar chamado solicitante-->
	
	
<script type="text/javascript">

function clear_formChamadoCad(ele) {
	$('#divSubCategoria').empty();
	$("#arrowSubCategoria").hide();
	$(ele).trigger("reset");
}

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
	               msg('#alertaCarregaSubCategoria','erro', msg_err);           
	            }
	         }
	      })
      }
   });
});

	
	
//Adicionar Chamado
$(function() {
   /*  Submit form using Ajax */
   $('#btnSalvarChamado').click(function(e) {
	   
      //Prevent default submission of form
      e.preventDefault();
      
      $.post({
    	 url : "${s:mvcUrl('CSC#adicionar').build() }", 
 	     data : $('form[name=chamadoForm]').serialize(),
 		 beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
             loading_show();  
       	 },
         success : function(res) {
        	loading_hide();
            if(res.validated){
               //Set response
               clear_formChamadoCad('#chamadoCadForm');
               $('#chamadoModal').modal('hide');
               msg('#resposta','sucesso', res.message);   
               
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
               });   
               msg('#alertaCadChamado','erro', msg_err);           
            }
         }
      })
   });
});


//Excluir chamado solicitante
$(function() {
	$('#btnExcluirChamadoSolicitante').click(function(e) {
	   e.preventDefault();
	   $.post({
	 	 url : "${s:mvcUrl('CSC#excluir').build() }", 
		     data : $('form[name=chamadoSolicitanteExcluirForm]').serialize(),
		     beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
	         loading_show();  
	   	 },
	      success : function(res) {
	     	loading_hide();
	         if(res.validated){
	            //Set responsealertaExcluirChamadoSolicitante
	            $('#chamadoSolicitanteExcluirModal').modal('hide');
	            msg('#resposta','sucesso', res.message);   
	            window.setTimeout(function() {
	  	             window.location.href = "${s:mvcUrl('CSC#chamadoSolicitante').build() }";
	       		   }, 3600);
	            
				}else{
				   //Set error messages
				   var msg_err = '';
				   $.each(res.errorMessages,function(key,value){
				   		msg_err = msg_err + "<li>"+ value +"</li>";
	               });  
				   msg('#alertaExcluirChamadoSolicitante','erro', msg_err);   
	         }
	      }
	   })
	});
});


//Editar chamado solicitante
$(function() {
/*  Submit form using Ajax */
	$('#btnSalvarEditarChamadoSolicitante').click(function(e) {
		   
	//Prevent default submission of form
	e.preventDefault();
	
	$.post({
		 url : "${s:mvcUrl('CSC#editarChamadoSolicitante').build() }", 
		     data : $('form[name=chamadoSolicitanteEditarForm]').serialize(),
		     beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
	      loading_show();  
		 },
		success : function(res) {
		 		loading_hide();
		      if(res.validated){
		         //Set response
		         clear_form('#chamadoSolicitanteEditarForm');
		         $('#chamadoSolicitanteEditarModal').modal('hide');
		         msg('#resposta','sucesso', res.message);           
			  }else{
			  	//Set error messages
				 var msg_err = '';
				 $.each(res.errorMessages,function(key,value){
				 		msg_err = msg_err + "<li>"+ value +"</li>";
		          });   
		         msg('#alertaEditarChamadoSolicitante','erro', msg_err);           
		      }
		   }
		})
	});
});

/**
*carregar modal atualizar chamado solicitante
**/       
function openModalEditarChamadoSolicitante(idChamado, dataAbertura, tipoCategoria, categoriaNome, subCategoriaNome) {
	$.ajax({
    	 url : "${s:mvcUrl('CSC#carregaDescricaoChamadoSolicitante').build() }", 
    	 data : {val:idChamado},
    	
 		 beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
             loading_show();
       	 },
         success : function(res) {
        	loading_hide();
            if(res.validated){
            	$("#idEditChamadoSolicitante").val(idChamado);
            	$("#dataAberturaEditChamadoSolicitante").val(dataAbertura);
            	$("#descricaoEditChamadoSolicitante").val(res.descricaoChamado);
            	$("#tipoCategoriaEditChamadoSolicitante").val(tipoCategoria);
            	$("#assuntoEditChamadoSolicitante").val(categoriaNome + " - " + subCategoriaNome);
            	$('#chamadoSolicitanteEditarModal').modal({backdrop: 'static', keyboard: false})  	
            	$('#chamadoSolicitanteEditarModal').modal('show');
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
               });   
               msg('#alertaEditarChamadoSolicitante','erro', msg_err);           
            }
         }
      })
}

/**
*carregar modal excluir chamado solicitante
**/       
function openModalExcluirChamadoSolicitante(idChamadoSolicitante, emailSolicitante, dataAberturaChamadoSolicitante) {
	$.ajax({
   	 url : "${s:mvcUrl('CSC#carregaDescricaoChamadoSolicitante').build() }", 
   	 data : {val:idChamadoSolicitante},
   	
		 beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
            loading_show();
      	 },
        success : function(res) {
       	loading_hide();
           if(res.validated){
	       	    $('#inputIdChamadoSolicitante').val(idChamadoSolicitante);
	       		$('#inputEmailSolicitante').val(emailSolicitante);
	       		$('#divExcluirChamadoSolicitante').empty();
	       		var resposta = "<h6 class='modal-title'>Deseja realmente excluir este chamado ? </h6>"
	       			+ "<ul>"
	       				+ "<li>Código: " + idChamadoSolicitante +"</li>"
	       		    	+ "<li>Criação: " + dataAberturaChamadoSolicitante +"</li>"
	       				+ "<li>Descrição:</li>"
	       			+ "</ul>";
	       		$("#descricaoExcluirChamadoSolicitante").val(res.descricaoChamado);	       			
	       		$('#divExcluirChamadoSolicitante').append(resposta);
        	}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
              });   
              msg('#alertaExcluirChamadoSolicitante','erro', msg_err);           
           }
        }
     })
}

</script>