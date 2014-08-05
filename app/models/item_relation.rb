class ItemRelation < ActiveRecord::Base
  belongs_to :item
  belongs_to :itemable, polymorphic: true

  attr_accessible :search, :item, :itemable_id, :name, :accession_no, :thumbnail, :url
  attr_accessor :search, :name, :thumbnail, :url

  accepts_nested_attributes_for :item

  after_initialize :set_search_attr

  def updated?
    [:name, :thumbnail, :url].each do |attr|
      if self.send(attr).present? and self.send(attr) != item.send(attr)
        return true
      end
    end

    false
  end

  private

  def set_search_attr
    self.search = "#{accession_no} - #{item.name}" if item
  end
end
