class Invitation < ActiveRecord::Base
  attr_accessible :post_id, :message, :recipient_name, :recipient_email

  belongs_to :post

  delegate :title, :creator_fullname, to: :post, prefix: true

  validates :post_id, presence: true, on: :update
  validates :recipient_email,
    presence: true,
     format: {
       with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
       message: 'Wrong email format' }
end
