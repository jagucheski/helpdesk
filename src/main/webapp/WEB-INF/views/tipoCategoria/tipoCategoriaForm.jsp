	<!-- Inicio Modal Novo TipoCategoria-->
	<div class="modal fade" id="tipoCategoriaModal" tabindex="-1" role="dialog"
		aria-labelledby="tipoCategoriaModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="tipoCategoriaCadForm" name="tipoCategoriaForm" method="POST" >
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="tipoCategoriaModalLabel">Novo Tipo Categoria</h5>
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
									<input type="text" id="descricaoEditTipoCategoria" name="descricao"
										class="form-control form-control-sm" maxlength="50"
										placeholder="Descrição" autofocus/>
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
							<div id="alertaCadTipoCategoria"></div> 					
							
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-info btn-sm" onclick="clear_form('#tipoCategoriaCadForm')" title="Limpar">
							<i class="fas fa-eraser"></i> Limpar</button>
						<button type="button" class="btn btn-secondary btn-sm" title="Fechar" onclick="clear_form('#tipoCategoriaCadForm')" data-dismiss="modal">
							<i class="fas fa-times"></i> Fechar</button>
						<button type="button" id="btnSalvarTipoCategoria" class="btn btn-primary btn-sm" title="Salvar">
							<i class="fas fa-save"></i> Salvar</button>
					</div>
				
			</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Novo tipoCategoria-->
	
	
	<!-- Inicio Modal Excluir tipoCategoria-->
	<div class="modal fade" id="tipoCategoriaExcluirModal" tabindex="-1" role="dialog"
		aria-labelledby="tipoCategoriaExcluirModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="tipoCategoriaExcluirForm" name="tipoCategoriaExcluirForm" method="POST">
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="tipoCategoriaModalLabel">Excluir Tipo Categoria</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body"> 
						<div id="divExcluirTipoCategoria"></div> 
						<input type="hidden" name="id" id="inputIdTipoCategoria" value=""/>					
						<input type="hidden" name="nome" id="inputNomeTipoCategoria" value=""/>
						<br/>
						<div id="alertaExcluirTipoCategoria"></div>					
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-secondary btn-sm" title="Cancelar" data-dismiss="modal">
							<i class="fas fa-times"></i> Cancelar</button>
						<button type="button" id="btnExcluirTipoCategoria" class="btn btn-danger btn-sm" title="Sim, excluir tipo categoria!">
							<i class="fas fa-trash"></i> Sim, excluir tipo categoria!</button>							
						
					</div>
				</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Excluir tipoCategoria-->
	
	<!-- Inicio Modal Editar tipoCategoria-->
	<div class="modal fade" id="tipoCategoriaEditarModal" tabindex="-1" role="dialog"
		aria-labelledby="tipoCategoriaEditarModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="tipoCategoriaEditarForm" name="tipoCategoriaEditarForm" method="POST" >
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="tipoCategoriaEditarModalLabel">Editar Tipo Categoria</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
							<div class="row">
								<div class="form-group col">
									<label for="id" >Código</label>
									<input type="text" id="idEditTipoCategoria" name="id" readonly="readonly"
										class="form-control form-control-sm"/>
	
								</div>
							</div>
							<div class="row">
								<div class="form-group col">
									<label for="nome" >Nome</label>
									<input type="text" id="nomeEditTipoCategoria" name="nome"
										class="form-control form-control-sm"
										placeholder="Nome" autofocus maxlength="50" />
	
								</div>
							</div>
							<div class="row">
								<div class="form-group col">
									<label for="nome" >Descrição</label>
									<input type="text" id="descricaoEditTipoCategoria" name="descricao"
										class="form-control form-control-sm"
										placeholder="Descrição" autofocus maxlength="50" />
	
								</div>
							</div>
							<div class="row">
								<div class="form-group col">
									<label for="statusEditTipoCategoria">Status</label> 
									<select id="statusEditTipoCategoria" name="status"  class="form-control form-control-sm">
								        <option value="true" label="Ativo"/>
								        <option value="false" label="Inativo"/>					        			       
								    </select>	
								</div>
								
							</div>	
							<br/>
							<div id="alertaEditarTipoCategoria"></div> 					
							
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-secondary btn-sm" title="Fechar" onclick="clear_form('#tipoCategoriaEditarForm')" data-dismiss="modal">
							<i class="fas fa-times"></i> Fechar</button>
						<button type="button" id="btnSalvarEditarTipoCategoria" class="btn btn-primary btn-sm" title="Salvar">
							<i class="fas fa-save"></i> Salvar</button>
					</div>
				
			</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Editar tipoCategoria-->
	
	
<script type="text/javascript">
//Adicionar TipoCategoria
$(function() {
   /*  Submit form using Ajax */
   $('#btnSalvarTipoCategoria').click(function(e) {
	   
      //Prevent default submission of form
      e.preventDefault();
      
      $.post({
    	 url : "${s:mvcUrl('TCC#adicionarTipoCategoria').build() }", 
 	     data : $('form[name=tipoCategoriaForm]').serialize(),
 		 beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
             loading_show();  
       	 },
         success : function(res) {
        	loading_hide();
            if(res.validated){
               //Set response
               clear_form('#tipoCategoriaCadForm');
               $('#tipoCategoriaModal').modal('hide');
               msg('#resposta','sucesso', res.message);           
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
               });   
               msg('#alertaCadTipoCategoria','erro', msg_err);           
            }
         }
      })
   });
});

//Excluir tipoCategoria
$(function() {
	$('#btnExcluirTipoCategoria').click(function(e) {
	   e.preventDefault();
	   $.post({
	 	 url : "${s:mvcUrl('TCC#excluirTipoCategoria').build() }", 
		     data : $('form[name=tipoCategoriaExcluirForm]').serialize(),
		     beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
	         loading_show();  
	   	 },
	      success : function(res) {
	     	loading_hide();
	         if(res.validated){
	            //Set response
	            $('#tipoCategoriaExcluirModal').modal('hide');
	            msg('#resposta','sucesso', res.message);           
				}else{
				   //Set error messages
				   var msg_err = '';
				   $.each(res.errorMessages,function(key,value){
				   	msg_err = msg_err + "<li>"+ value +"</li>";
	           	   });   
	           	   msg('#alertaExcluirTipoCategoria','erro', msg_err);
	         }
	      }
	   })
	});
});

//Editar setor
$(function() {
/*  Submit form using Ajax */
	$('#btnSalvarEditarTipoCategoria').click(function(e) {
		   
	  //Prevent default submission of form
	  e.preventDefault();
	  
	  $.post({
		 url : "${s:mvcUrl('TCC#editarTipoCategoria').build() }", 
		     data : $('form[name=tipoCategoriaEditarForm]').serialize(),
		     beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
	        loading_show();  
	  	 },
	     success : function(res) {
	   		loading_hide();
	        if(res.validated){
	           //Set response
	           clear_form('#tipoCategoriaEditarForm');
	           $('#tipoCategoriaEditarModal').modal('hide');
	           msg('#resposta','sucesso', res.message);           
				}else{
				   //Set error messages
				   var msg_err = '';
				   $.each(res.errorMessages,function(key,value){
				   		msg_err = msg_err + "<li>"+ value +"</li>";
	           });   
	           msg('#alertaEditarTipoCategoria','erro', msg_err);           
	        }
	     }
	  })
	});
});
</script>