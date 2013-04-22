// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-tags
//= require cocoon
//= require autocomplete

// Javascript for Bootstraps radio buttons within Simple Form
$(function() {
  $('div.btn-group[data-toggle-name]').each(function() {
    var group = $(this);
    var form = group.parents('form').eq(0);
    var name = group.attr('data-toggle-name');
    var hidden = $('input[name="' + name + '"]', form);
    $('button', group).each(function() {
      var button = $(this);
      button.on('click', function(e) {
        e.preventDefault(); 
        hidden.val($(this).val());
        if (name == 'post[type]') {
          if (hidden.val() == 'Question') {
            $('label#title').html('Your Concise Question');
            $('input[label="Post Thread"]').val('Submit Question');
          } else {
            $('label#title').html('Your Discussion Title');
            $('input[label="Post Thread"]').val('Create Discussion');
          }
        }
      });
      if (button.val() == hidden.val()) {
        button.addClass('active');
      }
    });
  });
});
// End
