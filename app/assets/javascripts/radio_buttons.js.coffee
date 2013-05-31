# javacript for bootstraps radio buttons within simple form
$ ->
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
  
      # to compensate for the postgres values 't' and 'f' 
      hidden_val = hidden.val()
      corrected_hidden_value = switch hidden_val
        when "t" then "true"
        when "f" then "false"
        else hidden_val

      if (button.val() == corrected_hidden_value)
        button.addClass('active')

  for grp in ['items', 'collaborators']
    do (grp) ->
      $div = $("##{grp}")
      
      unless $div.hasClass('visible')
        $(".btn-group.#{grp} button").on 'click', (e) ->
          if e.target.value is "false"
            $div.addClass('hidden')
          else
            $div.removeClass('hidden')

        if $(".btn-group.#{grp} button[value='true']").hasClass('active')
          $div.removeClass('hidden')
        else
          $div.addClass('hidden')


  # re-populate images after page refresh
  $('.item-group .item-image img').each (i, img) ->
    $img = $(img)
    thumbnail_src = $img.parent().siblings('[class$=_items_thumbnail]').find('input').val()
    $img.attr('src', thumbnail_src) unless thumbnail_src == ""
