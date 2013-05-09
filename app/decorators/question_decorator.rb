class QuestionDecorator < PostDecorator
  def header
    "#{creator.fullname} asked a question"
  end

  def comment_key
    'answer'
  end
end
