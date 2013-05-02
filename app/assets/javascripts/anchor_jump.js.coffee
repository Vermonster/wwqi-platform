$ ->
  anchor_id = window.location.hash
  if (anchor_id)
    $.scrollTo("a[href='#{anchor_id}']")
