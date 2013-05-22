class AdminUser < ActiveRecord::Base

  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me
  
  validates :first_name, :last_name, :email, presence: true
  validates :password, confirmation: true
  validates :password, presence: true, on: :create
  validates :email, uniqueness: true
  
end
