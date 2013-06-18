$(document).ready(function(){

  initializeTermsDialog('legal_terms');
  initializeTermsDialog('legal_terms_farsi');

  $('.language-select-dialog').click(function() {
    $('.terms-farsi-dialog').toggle();
    $('.terms-english-dialog').toggle();
    $('.select-farsi-dialog').toggle();
    $('.select-english-dialog').toggle();
  });

  $('#legal_terms, #legal_terms_farsi').mouseenter(
    function() {
      $('.icon-right-open-mini').css('color', '#8a6f17');
  });

  $('#legal_terms, #legal_terms_farsi').mouseleave(
    function() {
      $('.icon-right-open-mini').css('color', '#a08222');
  });

  $('.icon-right-open-mini').hover(
    function() {
    $('.icon-right-open-mini').css('cursor', 'pointer');
  });

});

function initializeTermsDialog(item) {
  var $dialog = $("#dialog");
  var $close = $(".close-dialog");
  var $link = $("#"+ item);
  $dialog.dialog({
      autoOpen: false,
      title: "Terms",
      maxWidth: 600,
      width: 'auto', //overcomes width: 'auto and maxWidth bug
      height: 500,
      fluid: true,
      draggable: false,
      resizable: false,
      modal: true
    });

  $link.click(function() {
    $dialog.dialog('open');
    if ($link.attr('id').match('farsi')) {
      $('.terms-english-dialog').css('display', 'none');
      $('.terms-farsi-dialog').css('display', 'block');
    } else {
      $('.terms-english-dialog').css('display', 'block');
      $('.terms-farsi-dialog').css('display', 'none');
    }      
  });

  $close.click(function() {
    $dialog.dialog('close');
  });
}
