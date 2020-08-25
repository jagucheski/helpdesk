<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>


<tags:pageTemplate bodyClass="background-color: #f5f5f5;">

	<div class="jumbotron" style="background-color: #f5f5f5;min-height: 580px !important;">
		<div class="container">
			<h2 class="display-3">Seja bem-vindo!</h2>
			<p>Esta é a página do Departamento de TI.<br/>
			Aqui você tem acesso a documentos, manuais, formulários de solicitação, perguntas frequentes e mais.<br/>
			Além disso é possível acessar o sistema de abertura de chamados.</p>				
		</div>
	</div>
	
	<div class="container">
		<div class="row">
			<div class="col-md-4">
				<h3>Contato</h3>
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
				<h3>Atendimento</h3>
				<ul> 
					<li>Segunda das 12h às 18h</li>
					<li>terça das 7h à 13h</li>
					<li>quarta das 7h à 13h</li>
					<li>quinta das 7h à 13h</li>
					<li>sexta das 7h à 13h</li>
				</ul>	
			</div>
			
			<div class="col-md-4">
				<h3>Endereço</h3>
				<p>Av. João Mosmann Filho, nº 143, 4° andar, Sala 41, Centro, Parobé.</p>
			</div>
		</div>		
	</div>	
	
</tags:pageTemplate>
	