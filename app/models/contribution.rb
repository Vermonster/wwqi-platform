class Contribution < ActiveRecord::Base
  attr_accessible :details, :uploads_attributes, :item_attributes, :creator_id, :type
  
  belongs_to :creator, class_name: 'User'
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :uploads, as: :uploadable, dependent: :destroy
  has_one :item, as: :itemable, dependent: :destroy

  validates :details, presence: true
  validates :creator_id, :presence => true, :unless => Proc.new {|contribution| contribution.type == "Correction"}

  accepts_nested_attributes_for :uploads, :item
  
  default_scope order('created_at DESC')
end
