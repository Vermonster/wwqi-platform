class Item < ActiveRecord::Base
  belongs_to :post
  belongs_to :comment
  attr_accessible :url, :name, :thumbnail, :accession_no, :search
  attr_accessor :search

  validates :url, :name, :thumbnail, :accession_no, presence: true
  validates :post_id, presence: { if: (:comment_id.blank?) }, on: :update
end
