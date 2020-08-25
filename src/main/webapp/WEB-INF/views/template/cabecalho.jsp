<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

 <header>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark py-md-1 ">
		<a class="navbar-brand" href="${s:mvcUrl('HC#home').build() }"  title="HelpDesk">HelpDesk</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#menu" aria-controls="menu" aria-expanded="false"
			aria-label="Alterna navegação">
			<span class="navbar-toggler-icon"></span>
		</button>
	
		<div class="collapse navbar-collapse" id="menu">
			<ul class="navbar-nav mr-auto">
					<li class="nav-item dropdown">
						<security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_SUP')">
							<a class="nav-link dropdown-toggle" href="#" 
								id="navbarDropdown" role="button" 
								data-toggle="dropdown" aria-haspopup="true"	
								aria-expanded="false"> Gerenciar </a>
							<div class="dropdown-menu" style="padding: 0;" aria-labelledby="navbarDropdown">
									<security:authorize access="hasRole('ROLE_ADMIN')">
										<a  class="dropdown-item" href="${s:mvcUrl('OC#operador').build() }"><i class="fas fa-user-cog" title="Operador"></i> Operador</a> 
									</security:authorize>
									<a  class="dropdown-item" href="${s:mvcUrl('SC#solicitante').build() }"> <i class="fas fa-users" title="Solicitantes"></i> Solicitantes</a>
									<security:authorize access="hasRole('ROLE_ADMIN')"> 
										<div class="dropdown-divider"></div>
										<a class="dropdown-item" href="#"><i class="fas fa-cogs" title="Configuração"></i> Configuração</a>
									</security:authorize>
							</div>
						</security:authorize>
					</li>
					
					<li class="nav-item">
						<a class="nav-link disabled" href="#">Acesso USER</a> 
					</li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" 
						id="navbarDropdown" role="button" 
						data-toggle="dropdown" aria-haspopup="true"	
						aria-expanded="false"> 
						<security:authentication property="principal" var="usuario"/>
	      	 			<i class="fas fa-user"></i>	 ${usuario.username }
	      	 		</a>
					<div class="dropdown-menu" style="padding: 0;" aria-labelledby="navbarDropdown">
							<a  class="dropdown-item" href="${s:mvcUrl('UC#usuarioAtualizarDados').build() }">
								<i class="fas fa-pencil-alt" title="Alterar Dados"></i> Atualizar dados</a>
					</div>
				</li>
			
				<li class="nav-item">
					<a class="nav-link"	href="<c:url value='/logout'/>">
						<i class="fas fa-sign-out-alt"  title="Sair"></i> Sair</a>					
				</li>
			</ul>
		</div>
	</nav>
</header>
	