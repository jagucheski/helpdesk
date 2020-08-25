	<!-- Inicio Modal Novo solicitante-->
	<div class="modal fade" id="solicitanteModal" tabindex="-1" role="dialog"
		aria-labelledby="solicitanteModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="solicitanteCadForm" name="solicitanteForm" method="POST" >
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="solicitanteModalLabel">Novo Solicitante</h5>
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
									<label for="telefone" class="sr-only">Telefone</label> 
									<input type="tel" id="telefone" name="telefone" 
										class="form-control form-control-sm"
										placeholder="Telefone" autofocus maxlength="15" 
										 onchange="javascript: fMasc( this, mTel );" oninput="javascript: fMasc( this, mTel );"
										/>
								</div>
								<div class="form-group col">
									<label for="ramal" class="sr-only">Ramal</label> 
									<input type="text" id="ramal" name="ramal" 
										class="form-control form-control-sm"
										placeholder="Ramal" autofocus maxlength="15"/>
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
							
							<div id="alertaCadSolicitante"></div> 					
							
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-info btn-sm" onclick="clear_form('#solicitanteCadForm')" title="Limpar">
							<i class="fas fa-eraser"></i> Limpar</button>
						<button type="button" class="btn btn-secondary btn-sm" title="Fechar" onclick="clear_form('#solicitanteCadForm')" data-dismiss="modal">
							<i class="fas fa-times"></i> Fechar</button>
						<button type="button" id="btnSalvarSolicitante" class="btn btn-primary btn-sm" title="Salvar">
							<i class="fas fa-save"></i> Salvar</button>
					</div>
				
			</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Novo solicitante-->
	
	<!-- Inicio Modal Excluir solicitante-->
	<div class="modal fade" id="solicitanteExcluirModal" tabindex="-1" role="dialog"
		aria-labelledby="solicitanteExcluirModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="solicitanteExcluirForm" name="solicitanteExcluirForm" method="POST">
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="solicitanteModalLabel">Excluir Solicitante</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body"> 
						<div id="divExcluirSolicitante"></div> 
						<input type="hidden" name="email" id="inputEmailSolicitante" value=""/>
						<div id="inputEmailSolicitante" style="margin-top: 15px;"></div> 	
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-secondary btn-sm" title="Cancelar" data-dismiss="modal">
							<i class="fas fa-times"></i> Cancelar</button>
						<button type="button" id="btnExcluirSolicitante" class="btn btn-danger btn-sm" title="Sim, excluir solicitante!">
							<i class="fas fa-trash"></i> Sim, excluir solicitante!</button>							
						
					</div>
				</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Excluir solicitante-->
	
		<!-- Inicio Modal Alterar Senha Solicitante-->
	<div class="modal fade" id="alterarSenhaSolicitanteModal" tabindex="-1" role="dialog"
		aria-labelledby="solicitanteAlterarSenhaModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="alterarSenhaSolicitanteForm" name="alterarSenhaSolicitanteForm" method="POST" >
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="solicitanteAtualizarModalLabel">Alterar Senha do Solicitante</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="form-group col">
								<label for="emailAltSenhaSolicitante">Email</label> 
								<input type="email" readonly="readonly" id="emailAltSenhaSolicitante" name="email" readonly value=""
									class="form-control form-control-sm" />
							</div>
						</div>
						<div class="row"> 
							<div class="form-group col"> 
								<label for="senhaAltSenhaSolicitante" >Nova Senha</label> 
								<div class="input-group" id="show_hide_password">
									<input type="password" id="senhaAltSenhaSolicitante" name="senha" 
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
									<input type="checkbox" id="alterarSenhaAltSenhaSolicitante" name="alterarSenha"  aria-label="Checkbox for following text input">
									<i style="height: calc(1.5em + .5rem + 2px); padding: .25rem .5rem; font-size: .875rem;" >
										Solicitar uma alteração de senha no próximo login</i>
								</div>
							</div>
						</div>					
						<div id="alertaAlterarSenhaSolicitante"></div> 					
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-secondary btn-sm" title="Fechar" onclick="clear_form('#alterarSenhaSolicitanteForm')" data-dismiss="modal">
							<i class="fas fa-times"></i> Fechar</button>
						<button type="button" id="btnsalvaAlterarSenhaSolicitante" class="btn btn-primary btn-sm" title="Salvar">
							<i class="fas fa-save"></i> Salvar</button>
					</div>
				
			</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Alterar Senha solicitante-->



	<!-- Inicio Modal Editar solicitante-->
	<div class="modal fade" id="solicitanteEditarModal" tabindex="-1" role="dialog"
		aria-labelledby="solicitanteEditarModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form id="solicitanteEditarForm" name="solicitanteEditarForm" method="POST" >
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="solicitanteEditarModalLabel">Editar Solicitante</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
							<div class="row">
								<div class="form-group col">
									<label for="nome" >Nome</label>
									<input type="text" id="nomeEditSolicitante" name="nome"
										class="form-control form-control-sm"
										placeholder="Nome" autofocus maxlength="50" />
	
								</div>
							</div>
							<div class="row">
								<div class="form-group col">
									<label for="email" >Email</label> 
									<input type="email" id="emailEditSolicitante" name="email" readonly="readonly"
										class="form-control form-control-sm" maxlength="100"
										placeholder="Email  -   email@exemplo.com" autofocus/>
								</div>
							</div>
							<div class="row">
								<div class="form-group col">
									<label for="telefone">Telefone</label> 
									<input type="tel" id="telefoneEditSolicitante" name="telefone" 
										class="form-control form-control-sm"
										placeholder="Telefone" autofocus maxlength="15" 
										 onchange="javascript: fMasc( this, mTel );" oninput="javascript: fMasc( this, mTel );"
										/>
								</div>
								<div class="form-group col">
									<label for="ramal">Ramal</label> 
									<input type="text" id="ramalEditSolicitante" name="ramal" 
										class="form-control form-control-sm"
										placeholder="Ramal" autofocus maxlength="15"/>
								</div>
							</div>	
							
							<input type="hidden" id="senhaEditSolicitante" name="senha" />
							<input type="hidden" id="alterarSenhaEditSolicitante" name="alterarSenha"/>
							
							<div id="alertaEditarSolicitante"></div> 					
							
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-secondary btn-sm" title="Fechar" onclick="clear_form('#solicitanteEditarForm')" data-dismiss="modal">
							<i class="fas fa-times"></i> Fechar</button>
						<button type="button" id="btnSalvarEditarSolicitante" class="btn btn-primary btn-sm" title="Salvar">
							<i class="fas fa-save"></i> Salvar</button>
					</div>
				
			</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Editar solicitante-->
	
	
<script type="text/javascript">
//Adicionar Solicitante
$(function() {
   /*  Submit form using Ajax */
   $('#btnSalvarSolicitante').click(function(e) {
	   
      //Prevent default submission of form
      e.preventDefault();
      
      $.post({
    	 url : "${s:mvcUrl('SC#adicionar').build() }", 
 	     data : $('form[name=solicitanteForm]').serialize(),
 		 beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
             loading_show();  
       	 },
         success : function(res) {
        	loading_hide();
            if(res.validated){
               //Set response
               clear_form('#solicitanteCadForm');
               $('#solicitanteModal').modal('hide');
               msg('#resposta','sucesso', res.message);           
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
               });   
               msg('#alertaCadSolicitante','erro', msg_err);           
            }
         }
      })
   });
});

//Excluir solicitante
$(function() {
	$('#btnExcluirSolicitante').click(function(e) {
	   e.preventDefault();
	   $.post({
	 	 url : "${s:mvcUrl('SC#excluir').build() }", 
		     data : $('form[name=solicitanteExcluirForm]').serialize(),
		     beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
	         loading_show();  
	   	 },
	      success : function(res) {
	     	loading_hide();
	         if(res.validated){
	            //Set response
	            $('#solicitanteExcluirModal').modal('hide');
	            msg('#resposta','sucesso', res.message);           
				}else{
				   //Set error messages
				   msg('#alertaExcluirSolicitante','erro', res.message);           
	         }
	      }
	   })
	});
});


//Atualizar senha solicitante
$(function() {
 /*  Submit form using Ajax */
 $('#btnsalvaAlterarSenhaSolicitante').click(function(e) {
	   
	   var senha =  $('#senhaAltSenhaSolicitante').val();
	   var alterarSenha =   $("#alterarSenhaAltSenhaSolicitante:checked").val();
	   var email =  $('#emailAltSenhaSolicitante').val();
	   
    //Prevent default submission of form
    e.preventDefault();
    
    $.post({
  	 url : "${s:mvcUrl('SC#alterarSenhaSolicitante').build() }",     	 
	     data : $('form[name=alterarSenhaSolicitanteForm]').serialize(),
	   	 beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
          loading_show();  
     	 },
		 success : function(res) {
			loading_hide();
          if(res.validated){
             //Set response
             clear_form('#solicitanteAlterarSenhaForm');
             $('#alterarSenhaSolicitanteModal').modal('hide');
             msg('#resposta','sucesso', res.message);           
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
             });   
             msg('#alertaAlterarSenhaSolicitante','erro', msg_err);           
          }
       }
    })
 });
});


//Atualizar solicitante
$(function() {
 /*  Submit form using Ajax */
 $('#btnSalvarEditarSolicitante').click(function(e) {
	   
    //Prevent default submission of form
    e.preventDefault();
    
    $.post({
  	 url : "${s:mvcUrl('SC#editarSolicitante').build() }", 
	     data : $('form[name=solicitanteEditarForm]').serialize(),
	     beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
          loading_show();  
    	 },
       success : function(res) {
     		loading_hide();
          if(res.validated){
             //Set response
             clear_form('#solicitanteEditarForm');
             $('#solicitanteEditarModal').modal('hide');
             msg('#resposta','sucesso', res.message);           
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
             });   
             msg('#alertaEditarSolicitante','erro', msg_err);           
          }
       }
    })
 });
});

</script>