class ResearchDecorator < PostDecorator
  def header
    "#{creator.first_name} shared research in progress"
  end

  def comment_key
    'comment'
  end
end
