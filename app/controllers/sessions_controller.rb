class SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in)
    sign_in(resource_name, resource)
    if request.xhr?
      render js: "window.location=#{my_profile_path.to_json}"      
    else
      respond_with resource, :location => after_sign_in_path_for(resource)
    end
  end
end
