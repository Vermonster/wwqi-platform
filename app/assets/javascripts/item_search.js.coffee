$ ->
  options =
    source: (request, response) ->
      $.ajax
        url: window.search_url.replace(/^http:|^https:/, window.location.protocol)
        dataType: "json"
        type: 'get'
        data:
          q: request.term
        beforeSend: (xhr) ->
          xhr.setRequestHeader 'Authorization', "Basic #{window.search_auth}"
        success: (data) ->
          response($.map(data.hits.hits, (item) ->
            label: "#{item._source.accession_num} - #{item._source.title_en}"
            thumbnail: item._source.thumbnail
            name: item._source.title_en
            url: item._source.url_en
            accession_no: item._source.accession_num))
    select: (event, ui) ->
      group = $(event.target).parents('.item-group')

      if ($(".item-group .item-image img").length <1)
        group.find(".item-image").append("<img />")

      group.find('img').attr('src', ui.item.thumbnail)
      group.find('input[id$="_url"]').val(ui.item.url)
      group.find('input[id$="_thumbnail"]').val(ui.item.thumbnail)
      group.find('input[id$="_accession_no"]').val(ui.item.accession_no)
      group.find('input[id$="_name"]').val(ui.item.name)

  $('#items').find('input[id$="_search"]').autocomplete(options)

  $('#items').on('cocoon:after-insert', (e, insertedItem) ->
    $(insertedItem).find('input[id$="_search"]').autocomplete(options))
