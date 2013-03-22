class Item < ActiveRecord::Base
  belongs_to :post
  attr_accessible :url

  validates :url, :post_id, presence: true
end
