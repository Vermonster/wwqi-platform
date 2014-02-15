class Item < ActiveRecord::Base
  has_many :item_relations
  attr_accessible :url, :name, :thumbnail, :accession_no
  validates :url, :name, :thumbnail, :accession_no, presence: true

  def name
    if (n = super).present?
      n
    else
      'Missing Item'
    end
  end
end
