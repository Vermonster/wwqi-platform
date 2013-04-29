# javacript for bootstraps radio buttons within simple form
$ ->
  $('#items').hide() unless $('#items input:first').val()
  $('#collaborators').hide() unless $('#collaborators input:first').val()
  
  $('div.btn-group[data-toggle-name]').each ->
    group = $(this)
    form = group.parents('form').eq(0)
    name = group.attr('data-toggle-name')
    hidden = $("input[name='#{name}']", form)
    $('button', group).each ->
      button  = $(this)
      button.on 'click', (e) ->
        e.preventDefault()
        hidden.val($(this).val())
        if (name == 'post[type]')
          if (hidden.val() == 'Question')
            $('label#title').html('Your Concise Question')
            $('input[label="Post Thread"]').val('Submit Question')
          else
            $('label#title').html('Your Discussion Title')
            $('input[label="Post Thread"]').val('Create Discussion')

      if (button.val() == hidden.val())
        button.addClass('active')

  for page in ['post', 'research']
    do (page) ->
      for pair in [['item_related', '#items'], ['private', '#collaborators']]
        do (pair) ->
          $(".btn-group[data-toggle-name='#{page}[#{pair[0]}]'] button").on 'click', (e) ->
            $items = $(pair[1])
            if e.target.value == "true"
              $items.show()
            else
              $items.hide()
