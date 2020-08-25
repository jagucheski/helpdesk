	<!-- Inicio Modal Nova Categoria-->
	<div class="modal fade" id="categoriaModal" tabindex="-1" role="dialog"
		aria-labelledby="categoriaModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="categoriaCadForm" name="categoriaForm" method="POST" >
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="categoriaModalLabel">Nova Categoria</h5>
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
							<br/>			
							<div id="alertaCadCategoria"></div> 					
							
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-info btn-sm" onclick="clear_form('#categoriaCadForm')" title="Limpar">
							<i class="fas fa-eraser"></i> Limpar</button>
						<button type="button" class="btn btn-secondary btn-sm" title="Fechar" onclick="clear_form('#categoriaCadForm')" data-dismiss="modal">
							<i class="fas fa-times"></i> Fechar</button>
						<button type="button" id="btnSalvarCategoria" class="btn btn-primary btn-sm" title="Salvar">
							<i class="fas fa-save"></i> Salvar</button>
					</div>
				
			</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Nova categoria-->
	
	
	<!-- Inicio Modal Excluir categoria-->
	<div class="modal fade" id="categoriaExcluirModal" tabindex="-1" role="dialog"
		aria-labelledby="categoriaExcluirModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="categoriaExcluirForm" name="categoriaExcluirForm" method="POST">
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="categoriaModalLabel">Excluir Categoria</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body"> 
						<div id="divExcluirCategoria"></div> 
						<input type="hidden" name="id" id="inputIdCategoria" value=""/>					
						<input type="hidden" name="nome" id="inputNomeCategoria" value=""/>
						<br/>
						<div id="alertaExcluirCategoria"></div>					
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-secondary btn-sm" title="Cancelar" data-dismiss="modal">
							<i class="fas fa-times"></i> Cancelar</button>
						<button type="button" id="btnExcluirCategoria" class="btn btn-danger btn-sm" title="Sim, excluir categoria!">
							<i class="fas fa-trash"></i> Sim, excluir categoria!</button>							
						
					</div>
				</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Excluir categoria-->
	
	<!-- Inicio Modal Editar categoria-->
	<div class="modal fade" id="categoriaEditarModal" tabindex="-1" role="dialog"
		aria-labelledby="categoriaEditarModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="categoriaEditarForm" name="categoriaEditarForm" method="POST" >
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="categoriaEditarModalLabel">Editar Categoria</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
							<div class="row">
								<div class="form-group col">
									<label for="id" >Código</label>
									<input type="text" id="idEditCategoria" name="id" readonly="readonly"
										class="form-control form-control-sm"/>
	
								</div>
							</div>
							<div class="row">
								<div class="form-group col">
									<label for="nome" >Nome</label>
									<input type="text" id="nomeEditCategoria" name="nome"
										class="form-control form-control-sm"
										placeholder="Nome" autofocus maxlength="50" />
	
								</div>
							</div>
							<div class="row">
								<div class="form-group col">
									<label for="statusEditCategoria">Status</label> 
									<select id="statusEditCategoria" name="status"  class="form-control form-control-sm">
								        <option value="true" label="Ativo"/>
								        <option value="false" label="Inativo"/>					        			       
								    </select>	
								</div>
							</div>	
							<br/>
							<div id="alertaEditarCategoria"></div> 					
							
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-secondary btn-sm" title="Fechar" onclick="clear_form('#categoriaEditarForm')" data-dismiss="modal">
							<i class="fas fa-times"></i> Fechar</button>
						<button type="button" id="btnSalvarEditarCategoria" class="btn btn-primary btn-sm" title="Salvar">
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
   $('#btnSalvarCategoria').click(function(e) {
	   
      //Prevent default submission of form
      e.preventDefault();
      
      $.post({
    	 url : "${s:mvcUrl('CC#adicionarCategoria').build() }", 
 	     data : $('form[name=categoriaForm]').serialize(),
 		 beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
             loading_show();  
       	 },
         success : function(res) {
        	loading_hide();
            if(res.validated){
               //Set response
               clear_form('#categoriaCadForm');
               $('#categoriaModal').modal('hide');
               msg('#resposta','sucesso', res.message);           
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
               });   
               msg('#alertaCadCategoria','erro', msg_err);           
            }
         }
      })
   });
});

//Excluir categoria
$(function() {
	$('#btnExcluirCategoria').click(function(e) {
	   e.preventDefault();
	   $.post({
	 	 url : "${s:mvcUrl('CC#excluirCategoria').build() }", 
		     data : $('form[name=categoriaExcluirForm]').serialize(),
		     beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
	         loading_show();  
	   	 },
	      success : function(res) {
	     	loading_hide();
	         if(res.validated){
	            //Set response
	            $('#categoriaExcluirModal').modal('hide');
	            msg('#resposta','sucesso', res.message);           
				}else{
					   //Set error messages
				   var msg_err = '';
				   $.each(res.errorMessages,function(key,value){
				   		msg_err = msg_err + "<li>"+ value +"</li>";
		           });   
		           msg('#alertaExcluirCategoria','erro', msg_err);           
	         }
	      }
	   })
	});
});

//Editar Categoria
$(function() {
/*  Submit form using Ajax */
	$('#btnSalvarEditarCategoria').click(function(e) {
		   
	  //Prevent default submission of form
	  e.preventDefault();
	  
	  $.post({
		 url : "${s:mvcUrl('CC#editarCategoria').build() }", 
		     data : $('form[name=categoriaEditarForm]').serialize(),
		     beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
	        loading_show();  
	  	 },
	     success : function(res) {
	   		loading_hide();
	        if(res.validated){
	           //Set response
	           clear_form('#categoriaEditarForm');
	           $('#categoriaEditarModal').modal('hide');
	           msg('#resposta','sucesso', res.message);           
				}else{
				   //Set error messages
				   var msg_err = '';
				   $.each(res.errorMessages,function(key,value){
				   		msg_err = msg_err + "<li>"+ value +"</li>";
	           });   
	           msg('#alertaEditarCategoria','erro', msg_err);           
	        }
	     }
	  })
	});
});

//funcao para não efetuar requisicao via post pelo formulario
$(function() {
   $('#categoriaCadForm').submit(function(event){
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