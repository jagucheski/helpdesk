<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>

<tags:pageTemplate >

<jsp:attribute name="extraScripts">
	<c:url value="/resources/js" var="jsPath" />
	<script type="text/javascript" src="${jsPath}/categoria.js"></script>   
</jsp:attribute>

<jsp:body>

	<main role="main" style="background-color: #f5f5f5;padding: 1rem;">
			<div class="container wrapper" >
					<h5 class="h5 mb-3 font-weight-normal">Vincular Sub-Categoria</h5>
					<hr/>
					<div class="row">
						<div class="form-group col">
							<label for="nomeCategoria" >Categoria</label>
							<input type="text" id="nomeCategoria" name="nome" readonly="readonly" value="${categoria.nome }"
								class="form-control form-control-sm"/>
	
						</div>
					</div>
					<hr/>
					
					<div class="row">
						<div class="form-group col-md-6" >
							<button type="button" class="btn btn-secondary btn-sm" title="Voltar" 
								onclick="window.location.href='${s:mvcUrl('CC#categoria').build() }'">
								<i class="fas fa-arrow-left"></i> Voltar</button>						
							<button type="button" id="btnAtivarSubcategoria" class="btn btn-success btn-sm" title="Vincular/Desvincular">
								<i class="fas fa-plus-circle"></i> Vincular/Desvincular</button>
						</div>
					</div>			
				
				<div id="respostaAtivarSubCategoria" ></div> 		
			</div>
	    <form:form name="categoriaEditarSubCategoriaForm" method="POST" commandName="categoria">
			<div class="container table-responsive-sm" style="margin-top: 10px !important; min-height:550px;" id="listaDeSubCategorias">
			
			 	<div class="row" style="height: 20px !important;">
				 	<div class="col-auto mr-auto"> 
					  	<h5 class="h5 mb-3 font-weight-normal">Lista de Sub-Categoria</h5>
					</div>				
				</div>
				<hr/>
				<input type="hidden" id="idCategoria" name="id" value="${categoria.id }"/>
				<table id="tableCategoria" class="table table-hover table-sm table-bordered" style="text-align:center;">
				  	<thead class="table-active">
						<tr>
							<th><input type="checkbox" id="selectAll" /></th>
							<th>Código</th>
							<th>Nome</th>
							<th>Status</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${subCategorias}" var="subCategoria">
							<tr>
							    <c:if test="${subCategoria.status == true}">
		 						    <td><form:checkbox path="subCategoriasAtivas" value="${subCategoria.nome}" /></td>
							    </c:if>
							    <c:if test="${subCategoria.status == false}">
		 						    <td><form:checkbox path="subCategoriasAtivas" value="${subCategoria.nome}" disabled="true" /></td>
							    </c:if>
								<td title="${subCategoria.id}">${subCategoria.id}</td>
								<td title="${subCategoria.nome}">${subCategoria.nome}</td>
								<td title="${subCategoria.status == true ? 'Ativo':'Inativo'}">${subCategoria.status == true ? 'Ativo':'Inativo'}</td>
							</tr>
						</c:forEach>
				  	</tbody>
				</table>
			</div>
		</form:form>
	</main>	

<script type="text/javascript">
$('#selectAll').click(function(e){        
	$(this).closest('#tableCategoria').find('td input:checkbox').prop('checked', this.checked);
});

//Ativar Subcategoria
$(function() {
   /*  Submit form using Ajax */
   $('#btnAtivarSubcategoria').click(function(e) {
	   
      //Prevent default submission of form
      e.preventDefault();
      
      $.post({
    	 url : "${s:mvcUrl('CC#vincularSubCategoria').build() }",
    	 data : $('form[name=categoriaEditarSubCategoriaForm]').serialize(),
         success : function(res) {
         
            if(res.validated){
               //Set response
               msg('#respostaAtivarSubCategoria','sucesso', res.message);           
			}else{
			   //Set error messages
			   var msg_err = '';
			   $.each(res.errorMessages,function(key,value){
			   		msg_err = msg_err + "<li>"+ value +"</li>";
               });   
               msg('#respostaAtivarSubCategoria','erro', msg_err);           
            }
         }
      })
   });
});



</script>
	
</jsp:body>

</tags:pageTemplate>		