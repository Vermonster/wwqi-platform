class Contribution < ActiveRecord::Base
  attr_accessible :details, :item_id, :creator_id, :type
  
  validates :details, :item_id, presence: true
  validates_presence_of :creator_id, :unless => Proc.new {|contribution| contribution.type == "Correction"}

  belongs_to :item
  belongs_to :creator, class_name: 'User'
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :uploads, as: :uploadable, dependent: :destroy

  accepts_nested_attributes_for :uploads
  
  default_scope order('created_at DESC')
end
