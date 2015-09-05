
$(function(){
  // var portal_terangkat = <%= @portal_terangkat == 'true' ? 'true' : 'false' %>;
  var portal_terangkat = <%= @portal_terangkat == 'true' ? 'true' : 'false' %>;
  if(portal_terangkat){
    window.setTimeout(function(){
      $.ajax({
        url: '<%= turunkan_portal_path %>'
      });
    }, 3000);
  };
});

$(document).ready(portal);