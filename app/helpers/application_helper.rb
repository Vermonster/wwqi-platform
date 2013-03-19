module ApplicationHelper
  def post_type_radio_options
    [['question', 'Question'], ['discussion', 'Discussion']]
  end

  def post_private_radio_options
    [['true', 'People I Choose'], ['false', 'Everyone']] 
  end

  def comment_btn_text(post)
    case post
    when Question
      "Submit answer"
    when Discussion
      "Submit reply"
    end
  end
end
