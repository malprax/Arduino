// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/


  $('#on').click(function(){
    $.get('/on')
  });
  $('#off').click(function(){
    $.get('/off')
  });
  var pusher = new Pusher('#{Pusher.key}');
  var channel = pusher.subscribe('button');
  channel.bind('down', function(data) {
    $('body').css({background: 'red'})
  });
  channel.bind('up', function(data) {
    $('body').css({background: 'white'})
  });