class Item < ActiveRecord::Base
  has_many :item_relations
  attr_accessible :url, :name, :thumbnail, :accession_no
  validates :url, :name, :thumbnail, :accession_no, presence: true
end
