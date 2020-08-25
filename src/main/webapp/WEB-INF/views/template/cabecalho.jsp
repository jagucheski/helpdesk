<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<nav class="navbar navbar-expand-lg navbar-light bg-light py-md-1 ">
	<a class="navbar-brand" href="${s:mvcUrl('HC#home').build() }" >
		<i class="fas fa-home" title="HelpDesk"></i> HelpDesk</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#menu" aria-controls="menu" aria-expanded="false"
		aria-label="Alterna navegação">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="menu">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item dropdown">
				<security:authorize access="hasRole('ROLE_ADMIN')"> 
					<a class="nav-link dropdown-toggle" href="#" 
						id="navbarDropdown" role="button" 
						data-toggle="dropdown" aria-haspopup="true"	
						aria-expanded="false"> Gerenciar </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a  class="dropdown-item" href="${s:mvcUrl('UC#usuario').build() }">
								<i class="fas fa-users" title="Usuários"></i> Usuários</a> 
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="#">
								<i class="fas fa-cogs" title="Configuração"></i> Configuração</a>
					</div>
				</security:authorize>
			</li>
			
			<li class="nav-item">
				<a class="nav-link disabled" href="#">Desativado</a> 
			</li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
      	 	<li class="nav-item">
      	 		<a class="nav-link"	 href="#" title="Usuário">
      	 			<security:authentication property="principal" var="usuario"/>
      	 			<i class="fas fa-user"></i>	 ${usuario.username }
      	 		</a>
      	 	</li>
			<li class="nav-item">
				<a class="nav-link"	href="<c:url value='/logout'/>">
					<i class="fas fa-sign-out-alt"  title="Sair"></i> Sair</a>					
			</li>
		</ul>
	</div>
</nav>
	