<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ attribute name="bodyClass" required="false" %>
<%@ attribute name="extraScripts" fragment="true" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<title>HelpDesk - Gerenciamento de Chamados</title>
		<c:url value="/resources/css" var="cssPath" />
		<c:url value="/resources/js" var="jsPath" /> 
		<c:url value="/resources/imagens" var="imgPath" /> 
		<c:url value="/resources/fontawesome" var="fontawesomePath" />
		<c:url value="/resources/dataTable" var="dataTablePath" />
		<c:url value="/resources/export" var="exportPath" />
		<link rel="stylesheet" href="${cssPath}/bootstrap.min.css" type="text/css" media="all"/>
		<link rel="stylesheet" href="${cssPath}/bootstrap-grid.min.css" type="text/css" media="all"/>
		<link rel="stylesheet" href="${cssPath}/bootstrap-theme.min.css" type="text/css" media="all"/>
		<link rel="stylesheet" href="${fontawesomePath}/css/all.css" type="text/css" media="all"/>
		<link rel="stylesheet" href="${dataTablePath}/datatables.min.css" type="text/css" media="all"/>
		<link rel="icon" href="${imgPath}/favicon.ico">
		<script type="text/javascript" src="${jsPath}/jquery-3.5.1.js"></script>
		<script type="text/javascript" src="${jsPath}/inputMask.js"></script>
		<script type="text/javascript" src="${jsPath}/bootstrap.min.js"></script>	
		<script type="text/javascript" src="${jsPath}/util.js"></script>		
		<script type="text/javascript" src="${dataTablePath}/datatables.min.js"></script>
		<script type="text/javascript" src="${exportPath}/shieldui-all.min.js"></script>
		<script type="text/javascript" src="${exportPath}/jszip.min.js"></script>
	</head>
	
	<body class="${bodyClass}">

	<%@ include file="/WEB-INF/views/template/cabecalho.jsp" %>

	<jsp:doBody />
	
	<jsp:invoke fragment="extraScripts"></jsp:invoke>

	<%@ include file="/WEB-INF/views/template/rodape.jsp" %>
	
	</body>
</html>
