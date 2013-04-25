$ ->
  $('.wysihtml5').each (i, elem) ->
    $(elem).wysihtml5
      "font-styles": false
      "emphasis": true
      "lists": true
      "html": false
      "link": true
      "image": false
      "color": false
