class DiscussionDecorator < PostDecorator
  def header
    "#{creator.first_name} started a discussion"
  end

  def comment_key
    'reply'
  end
end
