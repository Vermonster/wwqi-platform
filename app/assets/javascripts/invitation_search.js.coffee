$ ->
  renderFunc = (ul, item) ->
    $('<li>')
      .append("<a>#{item.label}<br>#{item.user_email}</a>")
      .appendTo(ul)

  options =
    source: '/autocomplete/users'
    minLength: 0
    messages:
      noResults: ''
      results: ->
    open: (event, ui) ->
      $("ul.ui-autocomplete").append("<li class='ui-menu-item' id='invite_user_link' role='presentation'><a href='#add_invitation' data-toggle='modal'>Invite the person!</a><span class='icon-right-open-mini'></span></li>")
    select: (event, ui) ->
      group = $(event.target).parents('.collaborator-group')
      if (typeof ui.item != 'undefined')
        group.find('input[id$="_user_id"]').val(ui.item.user_id)
      else
        group.find('input[id$="_term"]').val("")

  $('input[id$="_term"]')
    .autocomplete(options)
    .data("ui-autocomplete")?._renderItem = renderFunc

  $('#collaborators').on('cocoon:after-insert', (e, insertedItem) ->
    $(insertedItem)
      .find('input[id$="_term"]')
      .autocomplete(options)
      .data("ui-autocomplete")?._renderItem = renderFunc)
