class Post < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :creator, :class_name => :User
  has_many :uploads, as: :uploadable

  attr_accessible :title, :details, :item_related, :private, :creator_id

  validates :title, :details, :creator_id, :presence => true
end
