class Item < ActiveRecord::Base
  belongs_to :post
  attr_accessible :url, :name, :thumbnail, :item_id, :search
  attr_accessor :search

  validates :url, presence: true
  validates :post_id, presence: true, on: :update
end
