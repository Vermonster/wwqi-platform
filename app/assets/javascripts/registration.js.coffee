$ ->
  $('#registration')
    .on 'ajax:error', (event, xhr, status, error) ->
      new_form = $(xhr.responseText).children()
      $(this).empty().append new_form
    .on 'ajax:beforeSend', (event, xhr, settings) ->
      settings.dataType = 'html'
