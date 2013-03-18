class Comment < ActiveRecord::Base
  attr_accessible :details, :user_id

  belongs_to :user
  belongs_to :commentable, polymorphic: true, counter_cache: true
  has_many :uploads, as: :uploadable

  validates :details, :commentable_id, :user_id, presence: true 
end
