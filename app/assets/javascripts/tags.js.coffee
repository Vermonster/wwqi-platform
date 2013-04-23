$ ->
  $('.post_tag_list').hide()

  $('#tag-list').tags
    promptText: 'For each tag, type in a name and press enter.'

  $('#tag-list').on 'keypress', (e) ->
    if (e.keyCode is 13)
      tags = $('#tag-list').tags().getTags()
      $('#post_tag_list').val(tags.join(','))
      false
