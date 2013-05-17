class SiteController < ApplicationController
  def index
    redirect_to my_profile_path if current_user
  end
end
