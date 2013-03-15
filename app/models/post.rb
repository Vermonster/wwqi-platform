class Post < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :creator, :class_name => :User
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :uploads, as: :uploadable, dependent: :destroy
  has_many :followings, as: :followable, dependent: :destroy
  has_many :followers, through: :followings, class_name: :User

  attr_accessible :title, :details, :item_related, :private, :creator_id

  validates :title, :details, :creator_id, :presence => true
end
