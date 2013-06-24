class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :terms, :fullname, :is_admin, :token
  attr_accessor :terms, :token
  
  validates :first_name, :last_name, :email, presence: true
  validates :password, confirmation: true
  validates :password, presence: true, on: :create
  validates :email, uniqueness: true
  validates :terms, acceptance: true

  has_many :posts, foreign_key: :creator_id
  has_many :comments
  has_many :contributions, foreign_key: :creator_id
  has_many :followings
  has_many :followed_posts, through: :followings, source: :followable, source_type: 'Post'
  has_many :notifications
  has_many :invitations, foreign_key: :inviter_id, dependent: :destroy
  has_many :collaborators, dependent: :destroy

  after_create :register_as_collaborator

  after_create :register_as_collaborator

  def followed_questions_and_discussions
    followed_posts.where("type = 'Question' or type = 'Discussion'") 
  end

  def followed_researches
    followed_posts.where(type: 'Research')
  end

  def followed_contributions
    followed_contributions.where("type = 'Transcription' or type = 'Translation' or type = 'Biography'")
  end

  def unread_notifications
    notifications.where(unread: true).decorate
  end

  def collaborations
    collaborated_posts = Array.new
    collaborators.each do |c|
      collaborated_posts.push c.post.decorate
    end
    collaborated_posts
  end

  # Return full name
  def fullname
    "#{first_name} #{last_name}"
  end

  def following?(object)
    followings.where(followable_id: object.id).first
  end

  def register_as_collaborator
    unless token.nil? or token == ""
      p = Invitation.find_by_token(token).post
      Collaborator.create(user_id: self.id, post_id: p.id)
    end
  end
end
