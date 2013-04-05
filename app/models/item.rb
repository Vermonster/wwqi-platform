class Item < ActiveRecord::Base
  belongs_to :post
  attr_accessible :url, :name

  validates :url, :post_id, presence: true
end
