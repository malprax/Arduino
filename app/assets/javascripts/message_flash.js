var message = $(function(){
   	
	if ($('#flash').length > 0){
		setTimeout(function(){
			$('#flash').slideUp();
		}, 2000);
	};
});

$(document).ready(message);
