class Collaborator < ActiveRecord::Base
  belongs_to :post
  attr_accessible :user_id 

  validates :user_id, :post_id, presence: true

  def user_email
    User.find(user_id).email if user_id
  end

  def user_name
    User.find(user_id).fullname if user_id
  end

end
