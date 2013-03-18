class QuestionDecorator < PostDecorator
  def header
    "#{creator.first_name} asked a question"
  end

  def comment_key
    'answer'
  end
end
