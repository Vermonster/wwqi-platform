# encoding: utf-8

module ApplicationHelper
  def user_signed_in?
    current_user.present?
  end

  def safe_image_tag(src, opts={ })
    safe_src = src.presence || '/assets/noimage.jpg'
    image_tag safe_src, opts.reverse_merge(onError: "this.onerror=null;this.src='/assets/noimage.jpg';")
  end

  def post_type_radio_options
    [['Question', 'Question'], ['Discussion', 'Discussion']]
  end

  def post_private_radio_options
    [['true', 'People I Choose'], ['false', 'Everyone']]
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

  def avatar_url(user)
    if user.nil?
      "flag.png"
    else
      gravatar_id = Digest::MD5::hexdigest(user.email).downcase
      protocol = (defined?(request) ? request.protocol : 'http://')
      "#{protocol}gravatar.com/avatar/#{gravatar_id}.png?d=mm"
    end
  end

  def nav_link(text, path, controller_name, farsi_text=nil)
    case controller_name
    when String
      active = params['controller'] == controller_name
    when Array
      active = controller_name.include? params['controller']
    end

    capture_haml do
      haml_tag :li, class: (active ? 'active' : nil) do
        haml_concat link_to(text, path)
        haml_concat link_to(farsi_text, path, {:class => "farsi-link"})
      end
    end
  end

  def choose_edit_path(resource)
    case resource
    when Question, Discussion
      edit_post_path(resource)
    when Research
      edit_research_path(resource)
    when Contribution
      edit_contribution_path(resource)
    end
  end

end
