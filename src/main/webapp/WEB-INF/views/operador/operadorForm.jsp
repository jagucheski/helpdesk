	<!-- Inicio Modal Novo operador-->
	<div class="modal fade" id="operadorModal" tabindex="-1" role="dialog"
		aria-labelledby="operadorModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="operadorCadForm" name="operadorForm" method="POST" >
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="operadorModalLabel">Novo Operador</h5>
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
									<label for="email" class="sr-only">Email</label> 
									<input type="email" id="email" name="email" 
										class="form-control form-control-sm" maxlength="100"
										placeholder="Email  -   email@exemplo.com" autofocus/>
								</div>
							</div>
							<div class="row"> 
								<div class="form-group col"> 
									<label for="senha" class="sr-only">Senha</label> 
									<div class="input-group" id="show_hide_password">
										<input type="password" id="senha" name="senha" 
										       class="form-control form-control-sm" 
					 						   placeholder="Senha" autofocus maxlength="30"/>
									      	<button type="button" class="btn btn-dark btn-sm" onclick="showHidePassword()">
									    		<i class="fa fa-eye-slash" aria-hidden="true"></i>
									    	</button>
									</div>
								</div>
							</div>
							
							<div class="row"> 
								<div class="form-group col"> 
									<div style="height: 32px !important;" class="input-group-text"> 
										<input type="checkbox" id="alterarSenha" name="alterarSenha"  aria-label="Checkbox for following text input">
										<i style="height: calc(1.5em + .5rem + 2px); padding: .25rem .5rem; font-size: .875rem;" >
											Solicitar uma alteração de senha no próximo login</i>
									</div>
								</div>
							</div>
							
							<div id="alertaCadOperador"></div> 					
							
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-info btn-sm" onclick="clear_form('#operadorCadForm')" title="Limpar">
							<i class="fas fa-eraser"></i> Limpar</button>
						<button type="button" class="btn btn-secondary btn-sm" title="Fechar" onclick="clear_form('#operadorCadForm')" data-dismiss="modal">
							<i class="fas fa-times"></i> Fechar</button>
						<button type="button" id="btnSalvarOperador" class="btn btn-primary btn-sm" title="Salvar">
							<i class="fas fa-save"></i> Salvar</button>
					</div>
				
			</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Novo usuário-->
	
	<!-- Inicio Modal Excluir Operador-->
	<div class="modal fade" id="operadorExcluirModal" tabindex="-1" role="dialog"
		aria-labelledby="operadorExcluirModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="operadorExcluirForm" name="operadorExcluirForm" method="POST">
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="operadorModalLabel">Excluir Operador</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body"> 
						<div id="divExcluirOperador"></div> 
						<input type="hidden" name="email" id="inputEmailOperador" value=""/>
						<div id="inputEmailOperador" style="margin-top: 15px;"></div> 	
						<div id="alertaExcluirOperador"></div> 				
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-secondary btn-sm" title="Cancelar" data-dismiss="modal">
							<i class="fas fa-times"></i> Cancelar</button>
						<button type="button" id="btnExcluirOperador" class="btn btn-danger btn-sm" title="Sim, excluir operador!">
							<i class="fas fa-trash"></i> Sim, excluir operador!</button>							
						
					</div>
				</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Excluir usuário-->
	
		<!-- Inicio Modal Alterar Senha Operador-->
	<div class="modal fade" id="alterarSenhaOperadorModal" tabindex="-1" role="dialog"
		aria-labelledby="operadorAlterarSenhaModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="alterarSenhaOperadorForm" name="alterarSenhaOperadorForm" method="POST" >
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="operadorAtualizarModalLabel">Alterar Senha do Operador</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="form-group col">
								<label for="emailAltSenhaOperador">Email</label> 
								<input type="email" readonly="readonly" id="emailAltSenhaOperador" name="email" readonly value=""
									class="form-control form-control-sm" />
							</div>
						</div>
						<div class="row"> 
							<div class="form-group col"> 
								<label for="senhaAltSenhaOperador" >Nova Senha</label> 
								<div class="input-group" id="show_hide_password">
									<input type="password" id="senhaAltSenhaOperador" name="senha" 
									       class="form-control form-control-sm" 
				 						   placeholder="Nova Senha" autofocus maxlength="30"/>
								      	<button type="button" class="btn btn-dark btn-sm" onclick="showHidePassword()">
								    		<i class="fa fa-eye-slash" aria-hidden="true"></i>
								    	</button>
								</div>
							</div>
						</div>
								
						<div class="row"> 
							<div class="form-group col"> 
								<div style="height: 32px !important;" class="input-group-text"> 
									<input type="checkbox" id="alterarSenhaAltSenhaOperador" name="alterarSenha"  aria-label="Checkbox for following text input">
									<i style="height: calc(1.5em + .5rem + 2px); padding: .25rem .5rem; font-size: .875rem;" >
										Solicitar uma alteração de senha no próximo login</i>
								</div>
							</div>
						</div>					
						<div id="alertaAlterarSenhaOperador"></div> 					
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-secondary btn-sm" title="Fechar" onclick="clear_form('#alterarSenhaOperadorForm')" data-dismiss="modal">
							<i class="fas fa-times"></i> Fechar</button>
						<button type="button" id="btnsalvaAlterarSenhaOperador" class="btn btn-primary btn-sm" title="Salvar">
							<i class="fas fa-save"></i> Salvar</button>
					</div>
				
			</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Alterar Senha usuário-->
	
	<!-- Inicio Modal Editar operador-->
	<div class="modal fade" id="operadorEditarModal" tabindex="-1" role="dialog"
		aria-labelledby="operadorEditarModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="operadorEditarForm" name="operadorEditarForm" method="POST" >
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="operadorEditarModalLabel">Editar Operador</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
							<div class="row">
								<div class="form-group col">
									<label for="nome" >Nome</label>
									<input type="text" id="nomeEditOperador" name="nome"
										class="form-control form-control-sm"
										placeholder="Nome" autofocus maxlength="50" />
	
								</div>
							</div>
							<div class="row">
								<div class="form-group col">
									<label for="email" >Email</label> 
									<input type="email" id="emailEditOperador" name="email" readonly="readonly"
										class="form-control form-control-sm" maxlength="100"
										placeholder="Email  -   email@exemplo.com" autofocus/>
								</div>
							</div>
							
							<input type="hidden" id="senhaEditOperador" name="senha" />
							<input type="hidden" id="alterarSenhaEditOperador" name="alterarSenha"/>
							
							<div id="alertaEditarOperador"></div> 					
							
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-secondary btn-sm" title="Fechar" onclick="clear_form('#operadorEditarForm')" data-dismiss="modal">
							<i class="fas fa-times"></i> Fechar</button>
						<button type="button" id="btnSalvarEditarOperador" class="btn btn-primary btn-sm" title="Salvar">
							<i class="fas fa-save"></i> Salvar</button>
					</div>
				
			</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Editar operador-->
	
	
<script type="text/javascript">
//Adicionar Operador
$(function() {
   /*  Submit form using Ajax */
   $('#btnSalvarOperador').click(function(e) {
	   
      //Prevent default submission of form
      e.preventDefault();
      
      $.post({
    	 url : "${s:mvcUrl('OC#adicionar').build() }", 
 	     data : $('form[name=operadorForm]').serialize(),
 		 beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
             loading_show();  
       	 },
         success : function(res) {
        	loading_hide();
            if(res.validated){
               //Set response
               clear_form('#operadorCadForm');
               $('#operadorModal').modal('hide');
               msg('#resposta','sucesso', res.message);           
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
               });   
               msg('#alertaCadOperador','erro', msg_err);           
            }
         }
      })
   });
});


//Excluir operador
$(function() {
	$('#btnExcluirOperador').click(function(e) {
	   e.preventDefault();
	   $.post({
	 	 url : "${s:mvcUrl('OC#excluir').build() }", 
		     data : $('form[name=operadorExcluirForm]').serialize(),
		     beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
	         loading_show();  
	   	 },
	      success : function(res) {
	     	loading_hide();
	         if(res.validated){
	            //Set response
	            $('#operadorExcluirModal').modal('hide');
	            msg('#resposta','sucesso', res.message);           
				}else{
				  //Set error messages
				   var msg_err = '';
				   $.each(res.errorMessages,function(key,value){
				   		msg_err = msg_err + "<li>"+ value +"</li>";
	               });   
	               msg('#alertaExcluirOperador','erro', msg_err); 
	         }
	      }
	   })
	});
});

//Atualizar senha operador
$(function() {
   /*  Submit form using Ajax */
   $('#btnsalvaAlterarSenhaOperador').click(function(e) {
	   
	   var senha =  $('#senhaAltSenhaOperador').val();
	   var alterarSenha =   $("#alterarSenhaAltSenhaOperador:checked").val();
	   var email =  $('#emailAltSenhaOperador').val();
	   
      //Prevent default submission of form
      e.preventDefault();
      
      $.post({
    	 url : "${s:mvcUrl('OC#alterarSenhaOperador').build() }",     	 
 	     data : $('form[name=alterarSenhaOperadorForm]').serialize(),
 	   	 beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
            loading_show();  
       	 },
		 success : function(res) {
			loading_hide();
            if(res.validated){
               //Set response
               clear_form('#operadorAlterarSenhaForm');
               $('#alterarSenhaOperadorModal').modal('hide');
               msg('#resposta','sucesso', res.message);           
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
               });   
               msg('#alertaAlterarSenhaOperador','erro', msg_err);           
            }
         }
      })
   });
});

//Atualizar usuario
$(function() {
   /*  Submit form using Ajax */
   $('#btnSalvarEditarOperador').click(function(e) {
	   
      //Prevent default submission of form
      e.preventDefault();
      
      $.post({
    	 url : "${s:mvcUrl('OC#editarOperador').build() }", 
 	     data : $('form[name=operadorEditarForm]').serialize(),
 	     beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
            loading_show();  
      	 },
         success : function(res) {
       		loading_hide();
            if(res.validated){
               //Set response
               clear_form('#operadorEditarForm');
               $('#operadorEditarModal').modal('hide');
               msg('#resposta','sucesso', res.message);           
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
               });   
               msg('#alertaEditarOperador','erro', msg_err);           
            }
         }
      })
   });
});

</script>