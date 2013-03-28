class AutocompleteController < ApplicationController
  def users
    if params[:term]
      like = "%".concat(params[:term].concat("%"))
      users = User.where("first_name like ? or last_name like ? or email like ?", like, like, like) 
    else
      users = User.all
    end
    list = users.map { |u| Hash[ user_id: u.id, label: u.email, user_email: u.email, label: u.fullname, user_name: u.fullname ] }
    render json: list
  end
end
