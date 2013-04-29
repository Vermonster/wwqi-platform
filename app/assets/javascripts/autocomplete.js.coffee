$ ->
  renderFunc = (ul, item) ->
    $('<li>')
      .append("<a>#{item.label}<br><span class='email'>#{item.user_email}</span></a>")
      .appendTo(ul)

  options =
    source: '/autocomplete/users'
    messages: 
      noResults: ''
      results: ->
    open: (event, ui) ->
      $("ul.ui-autocomplete").append("<li class='ui-menu-item' id='invite_user_link' role='presentation'><a href='#'>Invite the person!</a></li>")
    select: (event, ui) ->
      group = $(event.target).parents('.collaborator-group')
      group.find('input[id$="_user_id"]').val(ui.item.user_id)
  
  $('input[id$="_term"]').autocomplete(options)
    .data("autocomplete")?._renderItem = renderFunc

  $('#collaborators').on('cocoon:after-insert', (e, insertedItem) ->
    $(insertedItem).find('input[id$="_term"]').autocomplete(options)
      .data("autocomplete")._renderItem = renderFunc)
