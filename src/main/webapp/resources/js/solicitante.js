/**
**Exemplo de uso:   onclick="setaDadosModalExcluir('#divExcluirOperador', '#inputEmailOperador', '${operador.email}')">
*	#divExcluirSolicitante: div com a mensagem e confirmação
*	#inputEmailSolicitante: input tipo hidden para guardar parametro
*	${operador.email}: valor id 
**/
function openModalExcluirSolicitante(div, campo, email) {
	$(campo).val(email);
	$(div).empty();
	var resposta = "<center><h6 class='modal-title'>Deseja realmente excluir o solicitante <br/>'" + email + "' ?</h6></center>"
	$(div).append(resposta);
}

/**carregar modal atualizar Solicitante
*/
function openModalEditarSolicitante(nome, email, telefone, ramal, senha, alterarSenha) {
	$("#nomeEditSolicitante").val(nome);
	$("#emailBaseEditSolicitante").val(email);
	$("#emailEditSolicitante").val(email);
	$("#telefoneEditSolicitante").val(telefone);
	$("#ramalEditSolicitante").val(ramal);
	$("#senhaEditSolicitante").val(senha);
	$("#alterarSenhaEditSolicitante").val(alterarSenha);

	if (alterarSenha == 'true') {
		$('#alterarSenhaEditSolicitante').prop("checked", true);
	} else {
		$('#alterarSenhaEditSolicitante').prop("checked", false);
	}

	$('#solicitanteEditarModal').modal({backdrop: 'static', keyboard: false})  	
	$('#solicitanteEditarModal').modal('show');
}

/**carregar modal atualizar senha solicitante
*/
function openModalAlterarSenhaSolicitante(email, alterarSenha) {
	
	$("#emailAltSenhaSolicitante").val(email);

	if (alterarSenha == 'true') {
		$('#alterarSenhaAltSenhaSolicitante').prop("checked", true);
	} else {
		$('#alterarSenhaAltSenhaSolicitante').prop("checked", false);
	}
				
	$('#alterarSenhaSolicitanteModal').modal({backdrop: 'static', keyboard: false})  				
	$('#alterarSenhaSolicitanteModal').modal('show');
}

/** https://datatables.net/*/
/**
* Configuração padrão das tabelas
**/
$(document).ready(function() {
	$('#tableSolicitante').dataTable({
		 responsive: true,
		"pageLength": 10,
		"lengthMenu": [ [10, 15, 25, -1], [10, 15, 25, "Todos"]],
		"language" : {
		    "search":         "Filtrar:",
			"emptyTable":     "Nenhum registro encontrado",
		    "info":           "Mostrando _START_ até _END_ de _TOTAL_ registros",
		    "infoEmpty":      "Mostrando 0 até 0 de 0 registros",
		    "infoFiltered":   " ( Filtrado de _MAX_ registros )",
		    "lengthMenu":     "Mostrar _MENU_ registros",
		    "loadingRecords": "Carregando...",
		    "processing":     "Processando...",
		    "zeroRecords":    "Nenhum registro encontrado de acordo com o filtro",
			"paginate": {
			        "first":      "Primeira",
			        "last":       "Última",
			        "next":       "Próxima",
			        "previous":   "Anterior"
			    }				
		}
	});

});


//Gerar PDF da tabela
//http://www.prepbootstrap.com/bootstrap-template/table-export-to-pdf
function exportaPDF(idtable) {
	// parse the HTML table element having an id=tablePaginate
	var dataSource = shield.DataSource.create({
		data: idtable,
		schema: {
			type: "table",
			fields: {
				Nome: { type: String },
				Email: { type: String },
				Telefone: { type: String },
				Ramal: { type: String }
			}
		}
	});

	// when parsing is done, export the data to PDF
	dataSource.read().then(function(data) {
		var pdf = new shield.exp.PDFDocument({
			author: "HelpDesk",
			fontSize: 10,
			created: new Date()
		});

		pdf.addPage("a4", "portrait");

		pdf.table(
			20,
			30,
			data,
			[
				{ field: "Nome", title: "Nome" },
				{ field: "Email", title: "Email" },
				{ field: "Telefone", title: "Telefone" },
				{ field: "Ramal", title: "Ramal" }
			],
			{
				margins: {
					top: 50,
					left: 50
				}
			}
		);

		pdf.saveAs({
			fileName: "helpdesk_solicitantes_PDF"
		});
	});
}


//Gerar Excel da tabela    
function exportaExcel(idtable) {
	// parse the HTML table element having an id=tablePaginate
	var dataSource = shield.DataSource.create({
		data: idtable,
		schema: {
			type: "table",
			fields: {
				Nome: { type: String },
				Email: { type: String },
				Telefone: { type: String },
				Ramal: { type: String }		
			}
		}
	});

	// when parsing is done, export the data to Excel
	dataSource.read().then(function(data) {
		new shield.exp.OOXMLWorkbook({
			author: "HelpDesk",
			worksheets: [
				{
					name: "HelpDesk Table",
					rows: [
						{
							cells: [
								{
									style: {
										bold: true
									},
									type: String,
									value: "Nome"
								},
								{
									style: {
										bold: true
									},
									type: String,
									value: "Email"
								},
								{
									style: {
										bold: true
									},
									type: String,
									value: "Telefone"
								},
								{
									style: {
										bold: true
									},
									type: String,
									value: "Ramal"
								}								
							]
						}
					].concat($.map(data, function(item) {
						return {
							cells: [
								{ type: String, value: item.Nome },
								{ type: String, value: item.Email },
								{ type: String, value: item.Telefone },
								{ type: Number, value: item.Ramal }
							]
						};
					}))
				}
			]
		}).saveAs({
			fileName: "helpdesk_solicitantes_Excel"
		});
	});
}