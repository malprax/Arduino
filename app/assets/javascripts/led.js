$(document).ready(function(){
	$('#angkat_portal').click(function(){
	   $.get('/angkat_portal')
     $('body').css({background: 'red'})
	 });

	$('#turunkan_portal').click(function(){
	   $.get('/turunkan_portal')
     $('body').css({background: 'white'})
	});

  var pusher = new Pusher('6a97661ed61a198a18cf');
  var channel = pusher.subscribe('button')
  channel.bind('down', function(data) {
   $('body').css({background: 'red'})
  });
  channel.bind('up', function(data) {
   $('body').css({background: 'white'})
  });
 

});


