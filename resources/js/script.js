$(document).ready(function() {

    $('.section-projects').waypoint(function (direction) {
        if (direction === "down") {
            $('nav').addClass('fixed');
        } else {
            $('nav').removeClass('fixed');
        }
    }, {
        offset: '60px;'
    });
});