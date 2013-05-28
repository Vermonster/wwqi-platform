class ItemRelation < ActiveRecord::Base
  belongs_to :item
  belongs_to :itemable, polymorphic: true
end
