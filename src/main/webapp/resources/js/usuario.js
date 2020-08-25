function showHidePassword() {
	if ($('#show_hide_password input').attr("type") == "text") {
		$('#show_hide_password input').attr('type', 'password');
		$('#show_hide_password i').addClass("fa-eye-slash");
		$('#show_hide_password i').removeClass("fa-eye");
	} else if ($('#show_hide_password input').attr("type") == "password") {
		$('#show_hide_password input').attr('type', 'text');
		$('#show_hide_password i').removeClass("fa-eye-slash");
		$('#show_hide_password i').addClass("fa-eye");
	}
}


/**
**Exemplo de uso:   onclick="setaDadosModalExcluir('#divExcluirUsuario', '#inputEmailUsuario', '${usuario.email}')">
*	#divExcluirUsuario: div com a mensagem e confirmação
*	#inputEmailUsuario: input tipo hidden para guardar parametro
*	${usuario.email}: valor id 
**/
function openModalExcluirUsuario(div, campo, email) {
	$(campo).val(email);
	$(div).empty();
	var resposta = "<h6 class='modal-title'>Deseja realmente excluir o usuário " + email + " ?</h6>"
	$(div).append(resposta);
}

/**carregar modal atualizar usuario
*/
function openModalEditarUsuario(nome, email, telefone, ramal, senha, alterarSenha) {
	$("#nomeEditUsuario").val(nome);
	$("#emailBaseEditUsuario").val(email);
	$("#emailEditUsuario").val(email);
	$("#telefoneEditUsuario").val(telefone);
	$("#ramalEditUsuario").val(ramal);
	$("#senhaEditUsuario").val(senha);
	$("#alterarSenhaEditUsuario").val(alterarSenha);

	if (alterarSenha == 'true') {
		$('#alterarSenhaEditUsuario').prop("checked", true);
	} else {
		$('#alterarSenhaEditUsuario').prop("checked", false);
	}

	$('#usuarioEditarModal').modal('show');
}

/**carregar modal atualizar senha usuario
*/
function openModalAlterarSenhaUsuario(email, alterarSenha) {
	$("#emailAltSenhaUsuario").val(email);

	if (alterarSenha == 'true') {
		$('#alterarSenhaAltSenhaUsuario').prop("checked", true);
	} else {
		$('#alterarSenhaAltSenhaUsuario').prop("checked", false);
	}

	$('#alterarSenhaUsuarioModal').modal('show');
}

//Gerar PDF da tabela
//http://www.prepbootstrap.com/bootstrap-template/table-export-to-pdf
jQuery(function($) {
	$("#btnExportPDF").click(function() {
		// parse the HTML table element having an id=tablePaginate
		var dataSource = shield.DataSource.create({
			data: "#tablePaginate",
			schema: {
				type: "table",
				fields: {
					Nome: { type: String },
					Email: { type: String },
					Telefone: { type: String },
					Ramal: { type: String },
					Perfil: { type: String }
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
				50,
				50,
				data,
				[
					{ field: "Nome", title: "Nome" },
					{ field: "Email", title: "Email" },
					{ field: "Telefone", title: "Telefone" },
					{ field: "Ramal", title: "Ramal" },
					{ field: "Perfil", title: "Perfil" }
				],
				{
					margins: {
						top: 50,
						left: 50
					}
				}
			);

			pdf.saveAs({
				fileName: "helpdesk_usuarios_PDF"
			});
		});
	});
});

//Gerar Excel da tabela    
jQuery(function($) {
	$("#btnExportExcel").click(function() {
		// parse the HTML table element having an id=tablePaginate
		var dataSource = shield.DataSource.create({
			data: "#tablePaginate",
			schema: {
				type: "table",
				fields: {
					Nome: { type: String },
					Email: { type: String },
					Telefone: { type: String },
					Ramal: { type: String },
					Perfil: { type: String }
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
									},
									{
										style: {
											bold: true
										},
										type: String,
										value: "Perfil"
									}
								]
							}
						].concat($.map(data, function(item) {
							return {
								cells: [
									{ type: String, value: item.Nome },
									{ type: String, value: item.Email },
									{ type: String, value: item.Telefone },
									{ type: Number, value: item.Ramal },
									{ type: String, value: item.Perfil }
								]
							};
						}))
					}
				]
			}).saveAs({
				fileName: "helpdesk_usuarios_Excel"
			});
		});
	});
});

