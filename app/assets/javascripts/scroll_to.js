$(document).ready(function(){
  console.log('test');
  $('#scroll-to-sign-in').localScroll({
    duration: 1000,
    offset: 10
  });

  $('#scroll-to-registration').localScroll({
    duration: 1000,
    offset: 20
  });

});
