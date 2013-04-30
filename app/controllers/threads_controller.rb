class ThreadsController < PostsController
  defaults resource_class: Post, route_collection_name: :posts, route_instance_name: :post

  # for autocomplete
  def user_email=(email)
    user = User.find_by_email(email)
    if user
      self.user_id = user.id
    else
      errors[:user_email] << "Invalid name entered"
    end
  end

  def user_email
    User.find(user_id).fullname if user_id
  end
  # end fo autocomplete
end
