<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>


<tags:pageTemplate bodyClass="background-color: #f5f5f5;">

<jsp:body>

	<main role="main" >
   		<div class="jumbotron" style="background-color: #f5f5f5;min-height: 600px !important;">
			<div class="container">
				<h2 class="display-4">Seja bem-vindo!</h2>
				<br/>
				<p>HelpDesk - Gerenciamento de Chamados<br/>
				Aqui você pode abrir chamados para suporte e acompanhar seu andamento em tempo real</p>				
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
				<div style="bottom: 2vh;right: 14px; z-index: 3; position: fixed; padding-top: 5px;">
					<button type="button" class="btn btn-info" title="Criar Chamado"
							style="box-shadow: 0 0 3px rgba(0,0,0,.14), 0 2px 4px rgba(0,0,0,.20);  border-radius: 50%; 
							width: 65px; height: 61px;"
							 onclick="window.location.href='${s:mvcUrl('CSC#chamadoSolicitante').build() }'">
					<i class="fas fa-tag"></i></button>
				</div>
			</div>	
	</main>	
	
</jsp:body>

</tags:pageTemplate>
	