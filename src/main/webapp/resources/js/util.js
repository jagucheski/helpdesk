/** https://datatables.net/*/
/**
* Configuração padrão das tabelas
**/
$(document).ready(function() {
	$('#tablePaginate').dataTable({
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

/**
* Isso funciona para todo .modal criado na página (mesmo modais dinâmicos)
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