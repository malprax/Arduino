$(document).ready(function () {
    // will call refreshPartial every 3 seconds
    setInterval(refreshIndex, 1000)

});

// calls action refreshing the partial
function refreshIndex() {
  $.ajax({
    url: "/billings"
 })
}