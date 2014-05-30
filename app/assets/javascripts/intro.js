$(document).ready(function(){

  $('.language-select-intro').click(function() {
    $('.intro-farsi').toggle();
    $('.intro-english').toggle();
    $('.select-farsi').toggle();
    $('.select-english').toggle();
    $('.intro-copy').toggle();
    $('.intro-copy-farsi').toggle();
    $('.feature-copy-farsi').toggle();
    $('.feature-copy').toggle();
    $('.question-discussion-feature').toggleClass('float-right');
    $('.research-feature').toggleClass('float-right');
    $('#legal_terms').toggle();
    $('#legal_terms_farsi').toggle();
    $('.sign-in-header').toggle();
  });

});

