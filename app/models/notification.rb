class Notification < ActiveRecord::Base
  attr_accessible :unread, :user_id, :notifiable_id

  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  validates :user_id, :notifiable_id, presence: true

  default_scope order('created_at DESC')
    
  def read!
    update_attribute(:unread, false)
  end
end
