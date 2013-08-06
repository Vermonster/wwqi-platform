class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  def after_sign_in_path_for(resource)
    session["user_return_to"] || my_profile_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
  
  def authenticate_admin
    current_user && current_user.is_admin? || redirect_to("/")
  end
  
  def current_admin_user
    current_user && current_user.is_admin ? current_user : nil
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
