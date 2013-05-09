class Comment < ActiveRecord::Base
  attr_accessible :details, :user_id, :commentable_id

  belongs_to :user
  belongs_to :commentable, polymorphic: true, counter_cache: true
  has_many :uploads, as: :uploadable
  has_many :notifications, as: :notifiable

  validates :details, :commentable_id, :user_id, presence: true

  def commentable_creator
    commentable.try(:creator) || commentable.user
  end
end
