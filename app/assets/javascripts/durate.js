$(document).ready(function () {
    setInterval(function () {
        $('.counter').each(function(){
          $(this).load('/durate?id='+$(this).attr('data-id'));
        });

    }, 1000);

});