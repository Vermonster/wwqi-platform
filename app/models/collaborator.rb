class Collaborator < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :user_id, :post_id, :term # term doesn't exist in database

  validates :user_id, presence: true
  validates :post_id, presence: true, on: :update

  def term
    # for the temporary field to display a user's full name.
    User.find(user_id).fullname if user_id
  end

  def term=(id)
    # setter method for the term field. It doesn't do any thing since the term
    # is not a real field. 

  end
end
