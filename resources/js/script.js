$(document).ready(function() {

    // fixed nav
    $('.section-projects').waypoint(function (direction) {
        if (direction === "down") {
            $('nav').addClass('fixed');
        } else {
            $('nav').removeClass('fixed');
        }
    }, {
        offset: '60px;'
    });

    // stop empty links
    $('a[href="#"]').click(function(e) {e.preventDefault(); });
});