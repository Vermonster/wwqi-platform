class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  # attr_accessible :title, :body
  
  validates :first_name, :last_name, :email, presence: true
  validates :password, confirmation: true
  validates :password, presence: true, on: :create
  validates :email, uniqueness: true

  has_many :posts, foreign_key: :creator_id
  has_many :comments
  has_many :contributions, foreign_key: :creator_id
  has_many :followings
  has_many :followed_posts, through: :followings, source: :followable, source_type: 'Post'

  def followed_questions_and_discussions
    followed_posts.where("type = 'Question' or type = 'Discussion'") 
  end

  def followed_researches
    followed_posts.where(type: 'Research')
  end

  # Retrun full name
  def fullname
    "#{first_name} #{last_name}"
  end

  def followed_questions_and_discussions
    followed_posts.where("type = 'Question' or type = 'Discussion'") 
  end

  def followed_researches
    followed_posts.where(type: 'Research')
  end
end
