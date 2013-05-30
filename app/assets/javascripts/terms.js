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
  var $close = $(".close-dialog");
  var $link = $("#legal_terms").one('click', function() {
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
        open: function(event, ui){
          //fluidDialog();
        }
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

// run function on all dialog opens
$(document).on("dialogopen", ".ui-dialog", function (event, ui) {
    //fluidDialog();
});

// remove window resize namespace
$(document).on("dialogclose", ".ui-dialog", function (event, ui) {
    $(window).off("resize.responsive");
});

function fluidDialog() {
    var $visible = $(".ui-dialog:visible");
    // each open dialog
    $visible.each(function () {
        var $this = $(this);
        var dialog = $this.find(".ui-dialog-content").data("dialog");
        // if fluid option == true
        if (dialog.options.maxWidth && dialog.options.width) {
            // fix maxWidth bug
            $this.css("max-width", dialog.options.maxWidth);
            //reposition dialog
            dialog.option("position", dialog.options.position);
        }

        if (dialog.options.fluid) {
            // namespace window resize
            $(window).on("resize.responsive", function () {
                var wWidth = $(window).width();
                // check window width against dialog width
                if (wWidth < dialog.options.maxWidth + 50) {
                    // keep dialog from filling entire screen
                    $this.css("width", "90%");

                }
              //reposition dialog
              dialog.option("position", dialog.options.position);
            });
        }

    });
}
