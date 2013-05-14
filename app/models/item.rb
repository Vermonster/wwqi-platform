class Item < ActiveRecord::Base
  belongs_to :itemable, polymorphic: true
  attr_accessible :url, :name, :thumbnail, :accession_no, :search, :itemable_id
  attr_accessor :search

  validates :url, :name, :thumbnail, :accession_no, presence: true
  validates :itemable_id, presence: true, on: :update
end
