class Post < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :creator, class_name: :User
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :uploads, as: :uploadable, dependent: :destroy
  has_many :followings, as: :followable, dependent: :destroy
  has_many :followers, through: :followings, class_name: :User
  has_many :items

  attr_accessible :title, :details, :item_related, :private, :creator_id, :type, 
    :tag_list, :uploads_attributes, :items_attributes

  validates :title, :details, :creator_id, presence: true

  accepts_nested_attributes_for :uploads, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :items, :reject_if => :all_blank, :allow_destroy => true

  default_scope order('created_at DESC')

  include PgSearch
  pg_search_scope :search_text, against: [:title, :details],
    associated_against: { tags: [:name] }
end
