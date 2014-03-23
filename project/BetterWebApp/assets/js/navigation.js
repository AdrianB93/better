$(document).ready(function() {
    $("#showmenu").click(function(event) {
        $("ul.nav-items").toggleClass("bloop");
        // Animate Later???
        $(".account-links").toggleClass("account-linksRESPONSIVE");
        $(".search").toggleClass("searchRESPONSIVE");
        event.preventDefault();
    });
});
