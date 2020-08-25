	<!-- Inicio Modal Novo usuário-->
	<div class="modal fade" id="usuarioModal" tabindex="-1" role="dialog"
		aria-labelledby="usuarioModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form:form action="${s:mvcUrl('UC#adicionar').build() }" id="usuarioCadForm" name="usuarioForm" method="POST" >
				<div class="modal-content">
				<div class="modal-header">
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
									placeholder="Email" autofocus/>
							</div>
						</div>
						<div class="row">
							<div class="form-group col">
								<label for="telefone" class="sr-only">Telefone</label> 
								<input type="tel" id="telefone" name="telefone" 
									class="form-control form-control-sm"
									placeholder="Telefone" autofocus maxlength="15"/>
							</div>
							<div class="form-group col">
								<label for="ramal" class="sr-only">ramal</label> 
								<input type="text" id="ramal" name="ramal" 
									class="form-control form-control-sm"
									placeholder="Ramal" autofocus maxlength="15"/>
							</div>
						</div>
						<div class="row">
							<div class="form-group col">
								<label for="perfil" class="sr-only">Perfil</label> <select
									id="perfil" class="form-control form-control-sm">
									<option selected>Perfil...</option>
									<option>...</option>
								</select>
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
									<input type="checkbox" aria-label="Checkbox for following text input">
									<i style="height: calc(1.5em + .5rem + 2px); padding: .25rem .5rem; font-size: .875rem;" >
										Solicitar uma alteração de senha no próximo login</i>
								</div>
							</div>
						</div>
						
						
									
						<div id="alertaCadUsuario"></div> 					
						
				</div>
				<div class="modal-footer" style="background-color: #f5f5f5;">
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

<script type="text/javascript">
$(function() {
   /*  Submit form using Ajax */
   $('#btnSalvarUsuario').click(function(e) {
	   
      //Prevent default submission of form
      e.preventDefault();
      
      //Remove all errors
//       $('input').next().remove();
      
      $.post({
    	 url : "${s:mvcUrl('UC#adicionar').build() }", 
 	     data : $('form[name=usuarioForm]').serialize(),
         success : function(res) {
         
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

</script>