$(document).ready(function(){

  $('.show-more').mouseenter(
    function() {
      $('#contributions-icon').css('color', '#eeeeee');
  });

  $('.show-more').mouseleave(
    function() {
      $('#contributions-icon').css('color', '#b29628');
  });

});
