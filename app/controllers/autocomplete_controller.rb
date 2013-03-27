class AutocompleteController < ApplicationController
  def users
    if params[:term]
      like = "%".concat(params[:term].concat("%"))
      users = User.where("first_name like ? or last_name like ? or email like ?", like, like, like) 
    else
      users = User.all
    end
    list = users.map { |u| Hash[ user_id: u.id, user_email: u.email, user_first_name: u.first_name, last_name: u.last_name ] }
    render json: list
  end
end
