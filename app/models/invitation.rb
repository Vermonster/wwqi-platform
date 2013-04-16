class Invitation < ActiveRecord::Base
  attr_accessible :inviter_id, :message, :recipient_name, :recipient_email

  belongs_to :inviter, class_name: :User

  delegate :fullname, :email, to: :inviter, prefix: true

  validates :inviter_id, presence: true
  validates :recipient_email,
    presence: true,
     format: {
       with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
       message: 'Wrong email format' }
end
