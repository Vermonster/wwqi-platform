$ ->
  for page in ['post', 'research']
    do (page) ->
      $(".#{page}_tag_list").hide()

        promptText: 'For each tag, type in a name and press enter.'
      $('.tag-list').tags
        tagClass: 'btn-inverse'

      $('.tag-list').on 'keypress', (e) ->
        if (e.keyCode is 13)
          tags = $('.tag-list').tags().getTags()
          $("##{page}_tag_list").val(tags.join(','))
          false
