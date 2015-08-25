// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
	
//= require jquery.cookie
//= require jstz
//= require browser_timezone_rails/set_time_zone
	
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .

	
	
$(function(){
	// setInterval(function(){
// 	    $.get('/billings/current', function(data) {
// 	      $('#status').html(data);
// 	      if ($('.time')) document.title = $('.time').html()+ '- Arduino';
// 	    });
// 	  }, 3000);

  	setInterval(function(){
  	    $.get('/billings/', function(data) {
  	      $('.time');
  	    });
  	  }, 3000);

	if ($('#flash').length > 0){
		setTimeout(function(){
			$('#flash').slideUp();
		}, 5000);
	}
});


function printpage()
{
   window.print()
}

$(document).on('click', '#exclude', function(){
	$('#report').find('.no_data').toggle();
});

$(function(){
	$('#angkat_portal').click(function(){
	   $.get('/angkat_portal')
	 });
 
	$('#turunkan_portal').click(function(){
	   $.get('/turunkan_portal')
	});
	 var pusher = new Pusher('#{Pusher.key}');
	 var channel = pusher.subscribe('button');
	 channel.bind('angkat_portal', function(data) {
	   $('body').css({background: 'red'})
	 });
	 channel.bind('turunkan_portal', function(data) {
	   $('body').css({background: 'white'})
	 });
	
});

		





