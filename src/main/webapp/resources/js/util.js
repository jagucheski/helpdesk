function hide(obj) {
	var el = document.getElementById(obj);
	el.style.display = 'none';
}

function clear_form(ele) {
	$(ele).trigger("reset");
}


/**
**Exemplo de uso:   msg('#resposta','sucesso', 'Configuracoes salvas com sucesso.');
**/
function msg(div, alerta, texto) {
	var resposta = '';
	$(div).empty();
	if (alerta === 'sucesso') {
		resposta = 	"<div class='alert alert-success alert-dismissible fade show' style='font-size: 1.rem;' role='alert' >"+
				"<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"+
		  			"<span aria-hidden='true'>&times;</span></button><ul> " + texto + "</ul></div>";			
	} else if (alerta === 'atencao') {
		resposta = "<div class='alert alert-warning talert-dismissible fade show' style='font-size: .875rem;' role='alert'>" +
			"<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"+
		  			"<span aria-hidden='true'>&times;</span></button><ul> " + texto + "</ul></div>";		
	} else if (alerta === 'erro') {
		resposta = "<div class='alert alert-danger talert-dismissible fade show' style='font-size: .875rem;' role='alert'>" +
			"<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"+
		  	"<span aria-hidden='true'>&times;</span></button><ul> " + texto + "</ul></div>";
	
 		
	}
	$(div).append(resposta);

	$(".alert").click(function() {
		$(".alert").hide();
	});
	
	$(document).ready(function() {

		window.setTimeout(function() {
			$(".alert").fadeTo(500, 0).slideUp(500, function() {
				$(this).remove();
			});
		}, 3000);

	});
	
}


function showHidePassword() {
    if($('#show_hide_password input').attr("type") == "text"){
        $('#show_hide_password input').attr('type', 'password');
        $('#show_hide_password i').addClass( "fa-eye-slash" );
        $('#show_hide_password i').removeClass( "fa-eye" );
    }else if($('#show_hide_password input').attr("type") == "password"){
        $('#show_hide_password input').attr('type', 'text');
        $('#show_hide_password i').removeClass( "fa-eye-slash" );
        $('#show_hide_password i').addClass( "fa-eye" );
    }
}


