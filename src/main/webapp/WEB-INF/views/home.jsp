<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>


<tags:pageTemplate bodyClass="background-color: #f5f5f5;">

<jsp:attribute name="extraScripts">

</jsp:attribute>
	
<jsp:body>

	<main role="main" >
   		<div class="jumbotron" style="background-color: #f5f5f5;min-height: 600px !important;">
			<div class="container" style="max-width: 1280px !important;">
				<h2 class="display-4">Seja bem-vindo!</h2>
				
				<div style="margin-left: 15px;margin-top:30px;">
					HelpDesk - Gerenciamento de Chamados<br/>
					Aqui você pode abrir chamados para suporte e acompanhar seu andamento em tempo real
				</div>		
				<hr/>
				
				<form:form id="usuarioForm" name="usuarioForm" method="POST" >
					<security:authentication property="principal" var="usuario"/>
					<input type="hidden" name="email" value="${usuario.email}"/>
				</form:form>
				
				<div id="chamados_chart" style="margin-top:75px;
											    background-color: white;
											    min-height: 400px;
											    max-width: 900px; 
											    border: 1px solid #ced4da; 
											    border-radius: .25rem; 
											    padding: 0.75rem;
											    display: none;">
				</div>
			</div>
		</div>
	
		<div class="container">
				<div class="row">
					<div class="col-md-4">
						<h5>Contato</h5>
						Telefone:<br/> 
						<ul>
							<li>(51) 3543.8600 Ramal: 212 ou 247</li>
						</ul>
						E-mail:<br/>
						<ul> 
							<li>ti.parobe@parobe.rs.gov.br</li>
							<li>suporte.ti@parobe.rs.gov.br</li>
						</ul>					
					</div>
					
					<div class="col-md-4">
						<h5>Atendimento</h5>
						<ul> 
							<li>Segunda das 12h às 18h</li>
							<li>terça das 7h à 13h</li>
							<li>quarta das 7h à 13h</li>
							<li>quinta das 7h à 13h</li>
							<li>sexta das 7h à 13h</li>
						</ul>	
					</div>
					
					<div class="col-md-4">
						<h5>Endereço</h5>
						<ul> 
							<li>Av. João Mosmann Filho, nº 143, 4° andar, Sala 41, Centro, Parobé/RS</li>
						</ul> 
					</div>
				</div>	
				<security:authentication property="principal" var="usuario"/>
				<c:if test="${usuario.operador eq false}">
					<div style="bottom: 2vh;right: 14px; z-index: 3; position: fixed; padding-top: 5px;">
						<button type="button" class="btn btn-info" title="Criar Chamado"
								style="box-shadow: 0 0 3px rgba(0,0,0,.14), 0 2px 4px rgba(0,0,0,.20);  border-radius: 50%; 
								width: 65px; height: 61px;"
								 onclick="window.location.href='${s:mvcUrl('CSC#chamadoSolicitante').build() }'">
						<i class="fas fa-tag"></i></button>
					</div>
				</c:if>
			</div>	
	</main>	
	
<script type="text/javascript">
google.charts.load('current', {'packages':['bar']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
	  
   $.post({
    	 url : "${s:mvcUrl('HC#garregaChart').build() }", 
    	 data : $('form[name=usuarioForm]').serialize(),
    	 beforeSend: function(){
    		 //Chama a função para mostrar a imagem gif de loading antes do carregamento
             loading_show();  
       	 },
         success : function(res) {
        	loading_hide();
            if(res.validated){
            	dados = res.data.replace(/'/g, '"');
            	 var data = google.visualization.arrayToDataTable(JSON.parse(dados));
                  	 
            	 var options = {
            	    chart: {
            	      title: res.titulo,
            	      subtitle: res.subTitulo,
            	    }
            	  };

            	  var chart = new google.charts.Bar(document.getElementById('chamados_chart'));
            	  chart.draw(data, google.charts.Bar.convertOptions(options));
               
			}
         }
      })
      
	$("#chamados_chart").show();
}


</script>
    
</jsp:body>

</tags:pageTemplate>
	