# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ -> 
  $('#collaborators').on('cocoon:after-insert', (e) ->
    item_id = $(this).context.children[$(this).context.children.length - 2].firstElementChild.id.split('_')[3]
    selector_for_email = 'input[name$=\"' + item_id + '][user_email]\"]'
    selector_for_id = 'input[name$=\"' + item_id + '][user_id]\"]'

    console.log(selector_for_email)
    console.log(selector_for_id)

    $(selector_for_email).autocomplete 
      source: '/autocomplete/users' 
      select: (event, ui) -> $(selector_for_id).val(ui.item.user_id)
  )
