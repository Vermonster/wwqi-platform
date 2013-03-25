class Collaborator < ActiveRecord::Base
  belongs_to :post
  attr_accessible :user_id

  validates :user_id, :post_id, presence: true
end
