<!-- Inicio Modal Excluir Usuário-->
	<div class="modal fade" id="usuarioExcluirModal" tabindex="-1" role="dialog"
		aria-labelledby="usuarioExcluirModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form action="${s:mvcUrl('UC#excluir').build() }" id="usuarioExcluirForm" name="usuarioExcluirForm" method="POST">
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="usuarioModalLabel">Excluir Usuário</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body"> 
						<div id="divExcluirUsuario"></div> 
						<input type="hidden" name="email" id="inputEmailUsuario" value=""/>							
						<div id="alertaExcluirUsuario" style="margin-top: 15px;"></div> 	
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-secondary btn-sm" title="Cancelar" data-dismiss="modal">
							<i class="fas fa-times"></i> Cancelar</button>
						<button type="button" id="btnExcluirUsuario" class="btn btn-danger btn-sm" title="Sim, excluir usuário!">
							<i class="fas fa-trash"></i> Sim, excluir usuário!</button>							
						
					</div>
				</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Excluir usuário-->
	
	<!-- Inicio Modal Novo usuário-->
	<div class="modal fade" id="usuarioModal" tabindex="-1" role="dialog"
		aria-labelledby="usuarioModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form action="${s:mvcUrl('UC#adicionar').build() }" id="usuarioCadForm" name="usuarioForm" method="POST" >
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="usuarioModalLabel">Novo Usuário</h5>
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
							
							<div id="alertaCadUsuario"></div> 					
							
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-info btn-sm" onclick="clear_form('#usuarioCadForm')" title="Limpar">
							<i class="fas fa-eraser"></i> Limpar</button>
						<button type="button" class="btn btn-secondary btn-sm" title="Fechar" onclick="clear_form('#usuarioCadForm')" data-dismiss="modal">
							<i class="fas fa-times"></i> Fechar</button>
						<button type="button" id="btnSalvarUsuario" class="btn btn-primary btn-sm" title="Salvar">
							<i class="fas fa-save"></i> Salvar</button>
					</div>
				
			</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Novo usuário-->

	<!-- Inicio Modal Atualizar usuário-->
	<div class="modal fade" id="usuarioEditarModal" tabindex="-1" role="dialog"
		aria-labelledby="usuarioAtualizarModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form action="${s:mvcUrl('UC#atualizarUsuario').build() }" id="usuarioAtualizarForm" name="usuarioAtualizarForm" method="POST" >
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="usuarioAtualizarModalLabel">Editar Usuário</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
							<div class="row">
								<div class="form-group col">
									<label for="nome" >Nome</label>
									<input type="text" id="nomeEditUsuario" name="nome"
										class="form-control form-control-sm"
										placeholder="Nome" autofocus maxlength="50" />
	
								</div>
							</div>
							<div class="row">
								<div class="form-group col">
									<label for="email" >Email</label> 
									<input type="email" id="emailEditUsuario" name="email" readonly="readonly"
										class="form-control form-control-sm" maxlength="100"
										placeholder="Email  -   email@exemplo.com" autofocus/>
								</div>
							</div>
							<div class="row">
								<div class="form-group col">
									<label for="telefone" >Telefone</label> 
									<input type="tel" id="telefoneEditUsuario" name="telefone"
										class="form-control form-control-sm"
										placeholder="Telefone" autofocus maxlength="15" 
										 onchange="javascript: fMasc( this, mTel );" oninput="javascript: fMasc( this, mTel );"
										/>
								</div>
								<div class="form-group col">
									<label for="ramal" >Ramal</label> 
									<input type="text" id="ramalEditUsuario" name="ramal"
										class="form-control form-control-sm"
										placeholder="Ramal" autofocus maxlength="15"/>
								</div>
							</div>
							
							<input type="hidden" id="emailBaseEditUsuario" name="emailBase"/>
							<input type="hidden" id="senhaEditUsuario" name="senha" />
							<input type="hidden" id="alterarSenhaEditUsuario" name="alterarSenha"/>
							
							<div id="alertaAtualizarUsuario"></div> 					
							
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-secondary btn-sm" title="Fechar" onclick="clear_form('#usuarioAtualizarForm')" data-dismiss="modal">
							<i class="fas fa-times"></i> Fechar</button>
						<button type="button" id="btnAtualizarUsuario" class="btn btn-primary btn-sm" title="Salvar">
							<i class="fas fa-save"></i> Salvar</button>
					</div>
				
			</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Atualizar usuário-->

	<!-- Inicio Modal Alterar Senha usuário-->
	<div class="modal fade" id="alterarSenhaUsuarioModal" tabindex="-1" role="dialog"
		aria-labelledby="usuarioAlterarSenhaModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form action="${s:mvcUrl('UC#alterarSenhaUsuario').build() }" id="alterarSenhaUsuarioForm" name="alterarSenhaUsuarioForm" method="POST" >
				<div class="modal-content">
					<div class="modal-header" style="background-color: #f5f5f5;">
						<h5 class="modal-title" id="usuarioAtualizarModalLabel">Alterar Senha do Usuário</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="form-group col">
								<label for="emailAltSenhaUsuario">Email</label> 
								<input type="email" readonly="readonly" id="emailAltSenhaUsuario" name="email" readonly value=""
									class="form-control form-control-sm" />
							</div>
						</div>
						<div class="row"> 
							<div class="form-group col"> 
								<label for="senhaAltSenhaUsuario" >Nova Senha</label> 
								<div class="input-group" id="show_hide_password">
									<input type="password" id="senhaAltSenhaUsuario" name="senha" 
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
									<input type="checkbox" id="alterarSenhaAltSenhaUsuario" name="alterarSenha"  aria-label="Checkbox for following text input">
									<i style="height: calc(1.5em + .5rem + 2px); padding: .25rem .5rem; font-size: .875rem;" >
										Solicitar uma alteração de senha no próximo login</i>
								</div>
							</div>
						</div>
							
						<div id="alertaAlterarSenhaUsuario"></div> 					
							
					</div>
					<div class="modal-footer" style="background-color: #e9ecef;">
						<button type="button" class="btn btn-secondary btn-sm" title="Fechar" onclick="clear_form('#alterarSenhaUsuarioForm')" data-dismiss="modal">
							<i class="fas fa-times"></i> Fechar</button>
						<button type="button" id="btnsalvaAlterarSenhaUsuario" class="btn btn-primary btn-sm" title="Salvar">
							<i class="fas fa-save"></i> Salvar</button>
					</div>
				
			</div>
			</form:form>
		</div>
	</div>
	<!-- Fim Modal Alterar Senha usuário-->

<script type="text/javascript">
//Atualizar senha usuario
$(function() {
   /*  Submit form using Ajax */
   $('#btnsalvaAlterarSenhaUsuario').click(function(e) {
	   
	   var senha =  $('#senhaAltSenhaUsuario').val();
	   var alterarSenha =   $("#alterarSenhaAltSenhaUsuario:checked").val();
	   var email =  $('#emailAltSenhaUsuario').val();
	   
      //Prevent default submission of form
      e.preventDefault();
      
      $.post({
    	 url : "${s:mvcUrl('UC#alterarSenhaUsuario').build() }",     	 
 	     data : $('form[name=alterarSenhaUsuarioForm]').serialize(),
 	   	 beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
            loading_show();  
       	 },
		 success : function(res) {
			loading_hide();
            if(res.validated){
               //Set response
               clear_form('#usuarioAlterarSenhaForm');
               $('#alterarSenhaUsuarioModal').modal('hide');
               msg('#resposta','sucesso', res.message);           
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
               });   
               msg('#alertaAlterarSenhaUsuario','erro', msg_err);           
            }
         }
      })
   });
});


//Adicionar usuario
$(function() {
   /*  Submit form using Ajax */
   $('#btnSalvarUsuario').click(function(e) {
	   
      //Prevent default submission of form
      e.preventDefault();
      
      $.post({
    	 url : "${s:mvcUrl('UC#adicionar').build() }", 
 	     data : $('form[name=usuarioForm]').serialize(),
 		 beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
             loading_show();  
       	 },
         success : function(res) {
        	loading_hide();
            if(res.validated){
               //Set response
               clear_form('#usuarioCadForm');
               $('#usuarioModal').modal('hide');
               msg('#resposta','sucesso', res.message);           
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
               });   
               msg('#alertaCadUsuario','erro', msg_err);           
            }
         }
      })
   });
});

//Atualizar usuario
$(function() {
   /*  Submit form using Ajax */
   $('#btnAtualizarUsuario').click(function(e) {
	   
      //Prevent default submission of form
      e.preventDefault();
      
      $.post({
    	 url : "${s:mvcUrl('UC#atualizarUsuario').build() }", 
 	     data : $('form[name=usuarioAtualizarForm]').serialize(),
 	     beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
            loading_show();  
      	 },
         success : function(res) {
       		loading_hide();
            if(res.validated){
               //Set response
               clear_form('#usuarioAtualizarForm');
               $('#usuarioEditarModal').modal('hide');
               msg('#resposta','sucesso', res.message);           
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
               });   
               msg('#alertaAtualizarUsuario','erro', msg_err);           
            }
         }
      })
   });
});

// Excluir usuario
$(function() {
   $('#btnExcluirUsuario').click(function(e) {
      e.preventDefault();
      $.post({
    	 url : "${s:mvcUrl('UC#excluir').build() }", 
 	     data : $('form[name=usuarioExcluirForm]').serialize(),
 	     beforeSend: function(){//Chama a função para mostrar a imagem gif de loading antes do carregamento
            loading_show();  
      	 },
         success : function(res) {
        	loading_hide();
            if(res.validated){
               //Set response
               $('#usuarioExcluirModal').modal('hide');
               msg('#resposta','sucesso', res.message);           
			}else{
			   //Set error messages
			   msg('#alertaExcluirUsuario','erro', res.message);           
            }
         }
      })
   });
});
</script>