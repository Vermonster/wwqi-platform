$(document).ready(function(){

  initializeTermsDialog();

  $('.language-select').click(function() {
    $('.terms-farsi').toggle();
    $('.terms-english').toggle();
    $('.select-farsi').toggle();
    $('.select-english').toggle();
  });

});

function initializeTermsDialog() {
  var $dialog = $("#dialog");
  var $link = $("#legal_terms").one('click', function() {
    $dialog.dialog({
        open: function(event, ui) { $(".ui-dialog-titlebar-close").hide(); },
        closeOnEscape: false,
        title: "Terms",
        width: 600,
        height: 500,
        draggable: false,
        resizable: false,
        modal: true
      });
    $dialog.bind('dialogbeforeclose', false);
    $link.click(function() {
      $dialog.dialog('open');

      return false;
    });

    return false;
  });
}
    

