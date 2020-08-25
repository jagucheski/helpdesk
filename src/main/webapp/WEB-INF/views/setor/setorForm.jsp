	<!-- Inicio Modal Novo setor-->
	<div class="modal fade" id="setorModal" tabindex="-1" role="dialog"
		aria-labelledby="setorModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="setorCadForm" name="setorForm" method="POST" >
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="setorModalLabel">Novo Setor</h5>
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
									<label for="descricao" class="sr-only">Descrição</label> 
									<input type="text" id="descricao" name="descricao" 
										class="form-control form-control-sm"
										placeholder="Descrição" autofocus maxlength="50"/>
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
							<div id="alertaCadSetor"></div> 					
							
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-info btn-sm" onclick="clear_form('#setorCadForm')" title="Limpar">
							<i class="fas fa-eraser"></i> Limpar</button>
						<button type="button" class="btn btn-secondary btn-sm" title="Fechar" onclick="clear_form('#setorCadForm')" data-dismiss="modal">
							<i class="fas fa-times"></i> Fechar</button>
						<button type="button" id="btnSalvarSetor" class="btn btn-primary btn-sm" title="Salvar">
							<i class="fas fa-save"></i> Salvar</button>
					</div>
				
			</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Novo setor-->
	
	<!-- Inicio Modal Excluir setor-->
	<div class="modal fade" id="setorExcluirModal" tabindex="-1" role="dialog"
		aria-labelledby="setorExcluirModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="setorExcluirForm" name="setorExcluirForm" method="POST">
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="setorModalLabel">Excluir Setor</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body"> 
						<div id="divExcluirSetor"></div> 
						<input type="hidden" name="id" id="inputIdSetor" value=""/>					
						<input type="hidden" name="nome" id="inputNomeSetor" value=""/>
						<div id="alertaExcluirSetor"></div>					
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-secondary btn-sm" title="Cancelar" data-dismiss="modal">
							<i class="fas fa-times"></i> Cancelar</button>
						<button type="button" id="btnExcluirSetor" class="btn btn-danger btn-sm" title="Sim, excluir setor!">
							<i class="fas fa-trash"></i> Sim, excluir setor!</button>							
						
					</div>
				</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Excluir setor-->
	
	<!-- Inicio Modal Editar setor-->
	<div class="modal fade" id="setorEditarModal" tabindex="-1" role="dialog"
		aria-labelledby="setorEditarModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="setorEditarForm" name="setorEditarForm" method="POST" >
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="setorEditarModalLabel">Editar Setor</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
							<div class="row">
								<div class="form-group col">
									<label for="idEditSetor" >Código</label>
									<input type="text" id="idEditSetor" name="id" readonly="readonly"
										class="form-control form-control-sm"/>
	
								</div>
							</div>
							<div class="row">
								<div class="form-group col">
									<label for="nomeEditSetor" >Nome</label>
									<input type="text" id="nomeEditSetor" name="nome"
										class="form-control form-control-sm"
										placeholder="Nome" autofocus maxlength="50" />
	
								</div>
							</div>
							<div class="row">
								<div class="form-group col">
									<label for="descricaoEditSetor" >Descrição</label> 
									<input type="text" id="descricaoEditSetor" name="descricao"
										class="form-control form-control-sm" maxlength="50"
										placeholder="Descrição" autofocus/>
								</div>
							</div>
							<div class="row">
								<div class="form-group col">
									<label for="statusEditSetor">Status</label> 
									<select id="statusEditSetor" name="status"  class="form-control form-control-sm">
								        <option value="true" label="Ativo"/>
								        <option value="false" label="Inativo"/>					        			       
								    </select>	
								</div>
								
							</div>	
							
							<div id="alertaEditarSetor"></div> 					
							
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-secondary btn-sm" title="Fechar" onclick="clear_form('#setorEditarForm')" data-dismiss="modal">
							<i class="fas fa-times"></i> Fechar</button>
						<button type="button" id="btnSalvarEditarSetor" class="btn btn-primary btn-sm" title="Salvar">
							<i class="fas fa-save"></i> Salvar</button>
					</div>
				
			</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Editar setor-->
	
	
<script type="text/javascript">
//Adicionar Setor
$(function() {
   /*  Submit form using Ajax */
   $('#btnSalvarSetor').click(function(e) {
	   
      //Prevent default submission of form
      e.preventDefault();
      
      $.post({
    	 url : "${s:mvcUrl('SC#adicionarSetor').build() }", 
 	     data : $('form[name=setorForm]').serialize(),
 		 beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
             loading_show();  
       	 },
         success : function(res) {
        	loading_hide();
            if(res.validated){
               //Set response
               clear_form('#setorCadForm');
               $('#setorModal').modal('hide');
               msg('#resposta','sucesso', res.message);           
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
               });   
               msg('#alertaCadSetor','erro', msg_err);           
            }
         }
      })
   });
});



//Excluir setor
$(function() {
	$('#btnExcluirSetor').click(function(e) {
	   e.preventDefault();
	   $.post({
	 	 url : "${s:mvcUrl('SC#excluirSetor').build() }", 
		     data : $('form[name=setorExcluirForm]').serialize(),
		     beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
	         loading_show();  
	   	 },
	      success : function(res) {
	     	loading_hide();
	         if(res.validated){
	            //Set response
	            $('#setorExcluirModal').modal('hide');
	            msg('#resposta','sucesso', res.message);           
				}else{
				   //Set error messages
				   msg('#alertaExcluirSetor','erro', res.message);           
	         }
	      }
	   })
	});
});


//Editar setor
$(function() {
/*  Submit form using Ajax */
$('#btnSalvarEditarSetor').click(function(e) {
	   
  //Prevent default submission of form
  e.preventDefault();
  
  $.post({
	 url : "${s:mvcUrl('SC#editarSetor').build() }", 
	     data : $('form[name=setorEditarForm]').serialize(),
	     beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
        loading_show();  
  	 },
     success : function(res) {
   		loading_hide();
        if(res.validated){
           //Set response
           clear_form('#setorEditarForm');
           $('#setorEditarModal').modal('hide');
           msg('#resposta','sucesso', res.message);           
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
           });   
           msg('#alertaEditarSetor','erro', msg_err);           
        }
     }
  })
});
});

</script>