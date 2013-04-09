class Item < ActiveRecord::Base
  belongs_to :post
  attr_accessible :url

  validates :url, presence: true
  validates :post_id, presence: true, on: :update
end
