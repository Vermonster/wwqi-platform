class Following < ActiveRecord::Base
  attr_accessible :user_id, :followable_id

  belongs_to :user
  belongs_to :followable, polymorphic: true

  validates :user_id, :followable_id, presence: true
end
