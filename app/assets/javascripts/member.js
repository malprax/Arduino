function printpage(){
  window.print()
}

// $(document).ready(function() {
//     // get data every 1 seconds and refresh myDiv
//     var pingAfter = 1000;
//     var refreshId = setInterval(function() {
//         window.reload('.member-index');
//     }, pingAfter);
// });

$(document).ready(function () {
    // will call refreshPartial every 3 seconds
    setInterval(refreshPartial, 3000)

});

// calls action refreshing the partial
function refreshPartial() {
  $.ajax({
    url: "members/"
 })
}