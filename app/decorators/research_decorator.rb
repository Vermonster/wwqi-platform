class ResearchDecorator < PostDecorator
  def header
    "#{creator.fullname} shared research in progress"
  end

  def comment_key
    'comment'
  end
end
