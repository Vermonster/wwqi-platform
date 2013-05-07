$ ->
  $('.item-follow-btn a.btn').click (e) ->
    e.preventDefault()

    $this = $(this)
    is_followed = $this.hasClass('followed')
    followable_type = $this.data('followable-type')
    followable_id = $this.data('followable-id')
    follow_id = $this.data('follow-id')

    controller = switch followable_type
      when 'question', 'discussion' then 'threads'
      when 'research' then 'researches'

    action = if is_followed then "DELETE" else "POST"
    url = switch is_followed
      when true then "/#{controller}/#{followable_id}/followings/#{follow_id}"
      else "/#{controller}/#{followable_id}/followings" 

    $.ajax
      url: url,
      type: action,
      success: (data, textStatus, jqXHR) ->
        if is_followed
          $this.text('Follow')
          $this.removeClass('followed')
        else
          $this.text('Unfollow')
          $this.addClass('followed')
