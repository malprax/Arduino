var led = $(function(){
  $('#angkat_portal').click(function(){
     $.get('/angkat_portal')
   });

  $('#turunkan_portal').click(function(){
     $.get('/turunkan_portal')
  });
  
  var pusher = new Pusher('429f0dfaaec2f4d689e8');
  var channel = pusher.subscribe('button')
  channel.bind('down', function(data) {
   $('body').css({background: 'red'})
  });
  channel.bind('up', function(data) {
   $('body').css({background: 'white'})
  });
  
   // var pusher = new Pusher('#{Pusher.key}');
   // var channel = pusher.subscribe('button');
 //   channel.bind('angkat_portal', function(data) {
 //     $('body').css({background: 'red'})
 //   });
 //   channel.bind('turunkan_portal', function(data) {
 //     $('body').css({background: 'white'})
 //   });
    
    // var channel = pusher.subscribe('button');
    // var channel = $(this).subscribe('button');
//     channel.bind('down', function(data) {
//      $('body').css({background: 'red'})
//     });
//     channel.bind('up', function(data) {
//      $('body').css({background: 'white'})
//     });

$( document ).ready(led);
// $( document ).ready(channel);

