$ ->
  $('#create_invitation').button().on('click',(e) ->
    e.preventDefault()
    # Check email is valid first
    regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/
    if (regex.test($('#modal_recipient_email').val()))
      console.log('hello')
    # when the email is valid
      $('a[data-association="invitation"]').trigger('click')
      names = $('input[id][name*="recipient_name"]') if $('#modal_recipient_name').val() isnt ""
      messages = $('input[id][name*="message"]') if $('#modal_message').val() isnt ""
      emails = $('input[id][name*="recipient_email"]')

      empty = i for em, i in emails when $(em).val() is ""

      debugger
      $(names[empty]).val($('input[id="modal_recipient_name"]').val()) if names?
      $(messages[empty]).val($('textarea[id="modal_message"]').val()) if messages?
      $(emails[empty]).val($('input[id="modal_recipient_email"]').val())
      $('input[id="modal_recipient_name"]').val("")
      $('input[id="modal_recipient_email"]').val("")
      $('textarea[id="modal_message"]').val("")
      $('#add_invitation').modal('hide')
    else
    # when the email is NOT valid
      $('#modal_recipient_email')
      .after('<span class="help-inline">Please check the email address</span>')
      .wrap('<div class="control" />')
      .wrap('<div class="control-group error" />'))
