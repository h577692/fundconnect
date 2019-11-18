$(document).ready(function() {

    /* For the sticky navigation */
    $('.section-projects').waypoint(function (direction) {
        if (direction == "down") {
            $('nav').addClass('fixed');
        } else {
            $('nav').removeClass('fixed');
        }
    }, {
        offset: '60px;'
    });
});