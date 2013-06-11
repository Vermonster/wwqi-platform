$(document).ready(function(){

  initializeTermsDialog();

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

function initializeTermsDialog() {
  var $dialog = $("#dialog");
  var $close = $(".close-dialog");
  var $link = $("#legal_terms, #legal_terms_farsi").one('click', function() {
    $dialog.dialog({
        //open: function(event, ui) { $(".ui-dialog-titlebar-close").show(); },
        autoOpen: true,
        //closeOnEscape: true,
        title: "Terms",
        maxWidth: 600,
        width: 'auto', //overcomes width: 'auto and maxWidth bug
        height: 500,
        fluid: true,
        draggable: false,
        resizable: false,
        modal: true,
      });

    $link.click(function() {
      $dialog.dialog('open');
      if ($link.attr('id')=='legal_terms'){
        $('.terms-english-dialog').css('display', 'block');
        $('.terms-farsi-dialog').css('display', 'none');
        console.log('english');
      } else {
        console.log('farsi');
        $('.terms-english-dialog').css('display', 'none');
        $('.terms-farsi-dialog').css('display', 'block');
      }      
      return false;
    });

    $close.click(function() {
      $dialog.dialog('close');
    });

    //return false;
  });
}
