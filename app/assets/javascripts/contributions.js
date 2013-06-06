$(document).ready(function(){

  $('.show-more-items').mouseenter(
    function() {
      $('#items-icon').css('color', '#333333');
  });

  $('.show-more-items').mouseleave(
    function() {
      $('#items-icon').css('color', '#b29628');
  });

  $('.show-more-contributions').mouseenter(
    function() {
      $('#recent-contributions-icon').css('color', '#333333');
  });

  $('.show-more-contributions').mouseleave(
    function() {
      $('#recent-contributions-icon').css('color', '#b29628');
  });
});
