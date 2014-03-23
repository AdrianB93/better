var clickedId;
$('li#challenger').click(function () {
    clickedId = $(this).find('a').attr('href');
    $('#chosen').attr("value", clickedId);
    alert("users id is " + clickedId);
});
