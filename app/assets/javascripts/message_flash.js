var message = $(function(){
   	
	if ($('#flash').length > 0){
		setTimeout(function(){
			$('#flash').slideUp();
		}, 5000);
	};
});

$(document).ready(message);
