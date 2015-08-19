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
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_self

	
	
$(function(){
	setInterval(function(){
	    $.get('/billings/current', function(data) {
	      $('#status').html(data);
	      if ($('.time')) document.title = $('.time').html()+ '- Arduino';
	    });
	  }, 3000);
	if ($('#flash').length > 0){
		setTimeout(function(){
			$('#flash').slideUp();
		}, 5000);
	}
});

$(document).on('click', '#exclude', function(){
	$('#report').find('.no_data').toggle();
});
