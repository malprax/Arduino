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
//= require pusher.min
//= require jquery.min
//= require led
//= require durate
//= require timer
//= require billing
//= require message_flash
//= require turbolinks
//= require_tree .
	

var main = $(function(){
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

$(document).ready(main);
//
//
// function printpage()
// {
//    window.print()
// }
//
// $(document).on('click', '#exclude', function(){
// 	$('#report').find('.no_data').toggle();
// });

