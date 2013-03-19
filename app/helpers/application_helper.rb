# encoding: utf-8

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
      "Submit Answer"
    when Discussion
      "Submit Reply"
    end
  end

  def flash_messages
    return if flash.empty?

    css = {
      alert: "alert-error",
      success: "alert-success",
      notice: "",
    }
    
    content_tag(:div, id: 'flash-messages') do
      flash.collect do |type, message|
        content_tag(:div, class: "flash-messages") do
          content_tag(:div, class: "alert #{css[type.intern]}") do
            concat button_tag("×", :type => "button", :name => nil, :class => "close", :"data-dismiss" => "alert")
            concat content_tag(:strong, message)
          end
        end
      end.join('\n').html_safe
    end    
  end
end
