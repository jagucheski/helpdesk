/**
* Faz com que todo .modal criado na página (mesmo modais dinâmicos)
* O pano de fundo instantaneamente sobrepõe o modal anterior
**/
$(document).on('show.bs.modal', '.modal', function () {
    var zIndex = 1040 + (10 * $('.modal:visible').length);
    $(this).css('z-index', zIndex);
    setTimeout(function() {
        $('.modal-backdrop').not('.modal-stack').css('z-index', zIndex - 1).addClass('modal-stack');
    }, 0);
});

function loading_show(){
	$('#carregandoModal').modal('show');
}
         
function loading_hide(){
	$('#carregandoModal').modal('hide');
}  
          
function hide(obj) {
	var el = document.getElementById(obj);
	el.style.display = 'none';
}

function clear_form(ele) {
	$(ele).trigger("reset");
}

function clear_field(ele) {
	$(ele).val("");
}

/**
**Exemplo de uso:   msg('#resposta','sucesso', 'Configuracoes salvas com sucesso.');
**/
function msg(div, alerta, texto) {
	var resposta = '';
	$(div).empty();
	if (alerta === 'sucesso') {
		resposta = 	"<div class='alert alert-success alert-dismissible fade show' style='font-size: 1.rem;height: 50px;' role='alert' >"+
				"<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"+
		  			"<span aria-hidden='true'>&times;</span></button><ul><i class='far fa-check-circle'></i>  "+ texto + "</ul></div>";			
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