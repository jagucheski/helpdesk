	<!-- Inicio Modal Nova Sub-Categoria-->
	<div class="modal fade" id="subCategoriaModal" tabindex="-1" role="dialog"
		aria-labelledby="subCategoriaModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="subCategoriaCadForm" name="subCategoriaCadForm" method="POST" >
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="subCategoriaModalLabel">Nova Sub-Categoria</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
							<div class="row">
								<div class="form-group col">
									<label for="nome" class="sr-only">Nome</label>
									<input
										type="text" id="nome" name="nome" 
										class="form-control form-control-sm"
										placeholder="Nome" autofocus maxlength="50" />
	
								</div>
							</div>
							<div class="row">
								<div class="form-group col">
									<label for="status" class="sr-only">Status</label> 
									<select id="status" name="status"  class="form-control form-control-sm">
								        <option value="true" label="Ativo"/>
								        <option value="false" label="Inativo"/>					        			       
								    </select>	
								</div>
							</div>							
							<div id="alertaCadSubCategoria"></div> 					
							
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-info btn-sm" onclick="clear_form('#subCategoriaCadForm')" title="Limpar">
							<i class="fas fa-eraser"></i> Limpar</button>
						<button type="button" class="btn btn-secondary btn-sm" title="Fechar" onclick="clear_form('#subCategoriaCadForm')" data-dismiss="modal">
							<i class="fas fa-times"></i> Fechar</button>
						<button type="button" id="btnSalvarSubCategoria" class="btn btn-primary btn-sm" title="Salvar">
							<i class="fas fa-save"></i> Salvar</button>
					</div>
				
			</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Nova Sub-categoria-->
	
	<!-- Inicio Modal Excluir sub-categoria-->
	<div class="modal fade" id="subCategoriaExcluirModal" tabindex="-1" role="dialog"
		aria-labelledby="subCategoriaExcluirModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="subCategoriaExcluirForm" name="subCategoriaExcluirForm" method="POST">
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="subCategoriaModalLabel">Excluir Sub-Categoria</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body"> 
						<div id="divExcluirSubCategoria"></div> 
						<input type="hidden" name="id" id="inputIdSubCategoria" value=""/>					
						<input type="hidden" name="nome" id="inputNomeSubCategoria" value=""/>
						<div style="margin-top:20px;" id="alertaExcluirSubCategoria"></div>					
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-secondary btn-sm" title="Cancelar" data-dismiss="modal">
							<i class="fas fa-times"></i> Cancelar</button>
						<button type="button" id="btnExcluirSubCategoria" class="btn btn-danger btn-sm" title="Sim, excluir categoria!">
							<i class="fas fa-trash"></i> Sim, excluir sub-categoria!</button>							
						
					</div>
				</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Excluir sub-categoria-->
	
	
	<!-- Inicio Modal Editar sub-categoria-->
	<div class="modal fade" id="subCategoriaEditarModal" tabindex="-1" role="dialog"
		aria-labelledby="subCategoriaEditarModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="subCategoriaEditarForm" name="subCategoriaEditarForm" method="POST" >
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="subCategoriaEditarModalLabel">Editar Sub-Categoria</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
							<div class="row">
								<div class="form-group col">
									<label for="idEditSubCategoria" >Código</label>
									<input type="text" id="idEditSubCategoria" name="id" readonly="readonly"
										class="form-control form-control-sm"/>
	
								</div>
							</div>
							<div class="row">
								<div class="form-group col">
									<label for="nomeEditSubCategoria" >Nome</label>
									<input type="text" id="nomeEditSubCategoria" name="nome"
										class="form-control form-control-sm"
										placeholder="Nome" autofocus maxlength="50" />
	
								</div>
							</div>
							<div class="row">
								<div class="form-group col">
									<label for="statusEditSubCategoria">Status</label> 
									<select id="statusEditSubCategoria" name="status"  class="form-control form-control-sm">
								        <option value="true" label="Ativo"/>
								        <option value="false" label="Inativo"/>					        			       
								    </select>	
								</div>
								
							</div>	
							
							<div id="alertaEditarSubCategoria"></div> 					
							
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-secondary btn-sm" title="Fechar" onclick="clear_form('#subCategoriaEditarForm')" data-dismiss="modal">
							<i class="fas fa-times"></i> Fechar</button>
						<button type="button" id="btnSalvarEditarSubCategoria" class="btn btn-primary btn-sm" title="Salvar">
							<i class="fas fa-save"></i> Salvar</button>
					</div>
				
			</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Editar categoria-->
	
<script type="text/javascript">
//Adicionar Categoria
$(function() {
   /*  Submit form using Ajax */
   $('#btnSalvarSubCategoria').click(function(e) {
	   
      //Prevent default submission of form
      e.preventDefault();
      
      $.post({
    	 url : "${s:mvcUrl('SCC#adicionarSubCategoria').build() }", 
 	     data : $('form[name=subCategoriaCadForm]').serialize(),
 		 beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
             loading_show();  
       	 },
         success : function(res) {
        	loading_hide();
            if(res.validated){
               //Set response
               clear_form('#subCategoriaCadForm');
               $('#subCategoriaModal').modal('hide');
               msg('#resposta','sucesso', res.message);           
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
               });   
               msg('#alertaCadSubCategoria','erro', msg_err);           
            }
         }
      })
   });
});


//Excluir sub-categoria
$(function() {
	$('#btnExcluirSubCategoria').click(function(e) {
	   e.preventDefault();
	   $.post({
	 	 url : "${s:mvcUrl('SCC#excluirSubCategoria').build() }", 
		     data : $('form[name=subCategoriaExcluirForm]').serialize(),
		     beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
	         loading_show();  
	   	 },
	      success : function(res) {
	     	loading_hide();
	         if(res.validated){
	            //Set response
	            $('#subCategoriaExcluirModal').modal('hide');
	            msg('#resposta','sucesso', res.message);           
				}else{
				 //Set error messages
				   var msg_err = '';
				   $.each(res.errorMessages,function(key,value){
				   		msg_err = msg_err + "<li>"+ value +"</li>";
	               });   
	               msg('#alertaExcluirSubCategoria','erro', msg_err);           
	         }
	      }
	   })
	});
});

//Editar sub-Categoria
$(function() {
/*  Submit form using Ajax */
	$('#btnSalvarEditarSubCategoria').click(function(e) {
		   
	  //Prevent default submission of form
	  e.preventDefault();
	  
	  $.post({
		 url : "${s:mvcUrl('SCC#editarSubCategoria').build() }", 
		     data : $('form[name=subCategoriaEditarForm]').serialize(),
		     beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
	        loading_show();  
	  	 },
	     success : function(res) {
	   		loading_hide();
	        if(res.validated){
	           //Set response
	           clear_form('#subCategoriaEditarForm');
	           $('#subCategoriaEditarModal').modal('hide');
	           msg('#resposta','sucesso', res.message);           
				}else{
				   //Set error messages
				   var msg_err = '';
				   $.each(res.errorMessages,function(key,value){
				   		msg_err = msg_err + "<li>"+ value +"</li>";
	           });   
	           msg('#alertaEditarSubCategoria','erro', msg_err);           
	        }
	     }
	  })
	});
});

//funcao para não efetuar requisicao via post pelo formulario
$(function() {
   $('#subCategoriaCadForm').submit(function(event){
       return checkFocus();
    });
 });

function checkFocus() {
 if ($('#nome').is(':focus')) {
    return false;
 }
 return true;
}

</script>