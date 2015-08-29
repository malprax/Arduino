$(document).ready(function () {
    setInterval(function () {

        $('.time-rect-container').load('/give_time');

    }, 1000);
	
    setInterval(function () {

        $('.duration').load('/durate');

    }, 1000);
});