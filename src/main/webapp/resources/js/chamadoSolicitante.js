/**
**Exemplo de uso:   onclick="setaDadosModalExcluir('#divExcluirOperador', '#inputEmailOperador', '${operador.email}')">
*	#divExcluirSetor: div com a mensagem e confirmação
*	#inputIdSetor: input tipo hidden para guardar parametro
*	${setor.id}: valor id 
**/
function openModalExcluirChamadoSolicitanteOld(idChamadoSolicitante, emailSolicitante, dataAberturaChamadoSolicitante, descricaoChamadoSolicitante) {
	$('#inputIdChamadoSolicitante').val(idChamadoSolicitante);
	$('#inputEmailSolicitante').val(emailSolicitante);
	$('#divExcluirChamadoSolicitante').empty();
	var resposta = "<h6 class='modal-title'>Deseja realmente excluir este chamado ? </h6>"
		+ "<ul>"
			+ "<li>Código: " + idChamadoSolicitante +"</li>"
	    	+ "<li>Criação: " + dataAberturaChamadoSolicitante +"</li>"
			+ "<li>Descrição: " + descricaoChamadoSolicitante +"</li>"
		+ "</ul>";
	$('#divExcluirChamadoSolicitante').append(resposta);
}

/**carregar modal atualizar chamado solicitante
*/
function openModalEditarChamadoSolicitanteOld(id, dataAbertura, descricao, tipoCategoria, categoriaNome, subCategoriaNome) {
	$("#idEditChamadoSolicitante").val(id);
	$("#dataAberturaEditChamadoSolicitante").val(dataAbertura);
	$("#descricaoEditChamadoSolicitante").val(descricao);
	$("#tipoCategoriaEditChamadoSolicitante").val(tipoCategoria);
	$("#assuntoEditChamadoSolicitante").val(categoriaNome + " - " + subCategoriaNome);
	$('#chamadoSolicitanteEditarModal').modal({backdrop: 'static', keyboard: false})  	
	$('#chamadoSolicitanteEditarModal').modal('show');
}

/** https://datatables.net/*/
/**
* Configuração padrão das tabelas
**/
$(document).ready(function() {
	$('#tableChamado').dataTable({
		 responsive: true,
	    "order": [],
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


//Gerar Excel da tabela    
function exportaExcel(idtable) {
	// parse the HTML table element having an id=tablePaginate
	var dataSource = shield.DataSource.create({
		data: idtable,
		schema: {
			type: "table",
			fields: {
				Cód: { type: String },
				Criação: { type: String },
				Status: { type: String },
				Assunto: { type: String },
				Tipo: { type: String },
				Descrição: { type: String }
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
									value: "Cód"
								},
								{
									style: {
										bold: true
									},
									type: String,
									value: "Criação"
								},
								{
									style: {
										bold: true
									},
									type: String,
									value: "Status"
								},
								{
									style: {
										bold: true
									},
									type: String,
									value: "Assunto"
								},
								{
									style: {
										bold: true
									},
									type: String,
									value: "Tipo"
								},
								{
									style: {
										bold: true
									},
									type: String,
									value: "Descrição"
								}									
							]
						}
					].concat($.map(data, function(item) {
						return {
							cells: [
								{ type: Number, value: item.Cód },
								{ type: String, value: item.Criação }, 
								{ type: String, value: item.Status }, 
								{ type: String, value: item.Assunto },
								{ type: String, value: item.Tipo },
								{ type: String, value: item.Descrição }
							]
						};
					}))
				}
			]
		}).saveAs({
			fileName: "helpdesk_chamados_Excel"
		});
	});
}