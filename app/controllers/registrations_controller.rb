class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up
        sign_up(resource_name, resource)
        if request.xhr?
          # If this request is from qajarwomen to start a discussion or to ask
          # a question, it routes to a new discussion or question path.
          if request.env["rack.session"]["user_return_to"].nil?
            render js: "window.location=#{my_profile_path.to_json}"
          else
            render js: "window.location=#{request.env['rack.session']['user_return_to'].to_json}"
          end
        else
          respond_with resource, :location => after_sign_up_path_for(resource)
        end
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      if request.xhr?
        respond_with resource do |format|
          format.html { render partial: 'partials/user_registration', layout: false, status: :bad_request }
        end
      else
        respond_with resource
      end
    end
  end
end
