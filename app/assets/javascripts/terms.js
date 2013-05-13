$(document).ready(function(){

  initializeTermsDialog();

  $('.language-select').click(function() {
    $('.terms-farsi').toggle();
    $('.terms-english').toggle();
    $('.select-farsi').toggle();
    $('.select-english').toggle();
  });

  $('#legal_terms').mouseenter(
    function() {
      $('.icon-right-open-mini').css('color', '#8a6f17');
  });

  $('#legal_terms').mouseleave(
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
  var $close = $("#close-dialog");
  var $link = $("#legal_terms").one('click', function() {
    $dialog.dialog({
        //open: function(event, ui) { $(".ui-dialog-titlebar-close").show(); },
        closeOnEscape: true,
        title: "Terms",
        width: 600,
        height: 500,
        draggable: false,
        resizable: false,
        modal: true,
      });
    $link.click(function() {
      $dialog.dialog('open');

      return false;
    });
    $close.click(function() {
      $dialog.dialog('close');
    });

    return false;
  });
}
