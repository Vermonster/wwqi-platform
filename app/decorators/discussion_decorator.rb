class DiscussionDecorator < PostDecorator
  def header
    "#{creator.fullname} started a discussion"
  end

  def comment_key
    'reply'
  end
end
