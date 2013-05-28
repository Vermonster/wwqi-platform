class ItemRelation < ActiveRecord::Base
  belongs_to :item
  belongs_to :itemable, polymorphic: true
  
  attr_accessible :search, :item, :itemable_id, :name, :accession_no, :thumbnail, :url
  attr_accessor :search, :name, :accession_no, :thumbnail, :url

  accepts_nested_attributes_for :item
  
end
