class Post < ActiveRecord::Base
  acts_as_taggable
  include AssociateItems
  
  belongs_to :creator, class_name: :User
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :uploads, as: :uploadable, dependent: :destroy
  has_many :followings, as: :followable, dependent: :destroy
  has_many :followers, through: :followings, class_name: :User
  has_many :item_relations, as: :itemable, dependent: :destroy
  has_many :items, through: :item_relations
  has_many :collaborators, dependent: :destroy
  has_many :invitations, dependent: :destroy
  attr_accessible :title, :details, :item_related, :private, :creator_id, :type, :tag_list, :uploads_attributes, :item_relations_attributes, :collaborators_attributes, :invitations_attributes
  delegate :fullname, to: :creator, prefix: true

  validates :title, :details, :creator_id, presence: true
  validate :collaborator_duplication
  validate :item_duplication
  before_validation :mark_empty_collaborator_for_removal

  accepts_nested_attributes_for :uploads, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :item_relations, :reject_if => :not_item_related?, :allow_destroy => true
  accepts_nested_attributes_for :collaborators, :reject_if => :not_private?, :allow_destroy => true
  accepts_nested_attributes_for :invitations, reject_if: :all_blank, allow_destroy: true

  default_scope order('created_at DESC')
  scope :questions_and_discussions, where("type = 'Question' or type = 'Discussion'")
  scope :researches, where("type = 'Research'")
  
  search_methods :user_fullname_contains
    
  scope :user_fullname_contains, lambda { |str|
    User.joins(:creator).where("LOWER(first_name) = LOWER(?) OR LOWER(last_name) = LOWER(?)", str, str)
  }

  after_create do |post|
    if ENV['ADMIN_NOTIFICATION_EMAIL']
      AdminNotificationMailer.new_post(post).deliver
    end
  end

  include PgSearch
  pg_search_scope :search_text, against: [:title, :details],
    associated_against: { tags: [:name] }

  def not_item_related?
    !item_related
  end

  def not_private?
    !private?
  end

  def can_see?(user)
    if user.nil?
      not_private?
    else
      not_private? || user == creator || collaborators.where(user_id: user.id).exists? 
    end
  end
  
  private

  def collaborator_duplication
    # a quick validtion method for checking a duplication of recipients with the
    # post

    # Get the number of the user_ids in the list that are uniquely identified.
    num_of_unique = collaborators.map(&:user_id).uniq.length

    # Compare to the length of the collaborators array against to num_of_unique.
    # If they are same, each collaborators are unique. If not, one or more
    # collaborators are added more than once. 
    if collaborators.length != num_of_unique 
      errors.add(:collaborators, 'You have duplicate collaborators listed.')
    end
  end

  def item_duplication
    unique = item_relations.map(&:accession_no).uniq.length

    if item_relations.length != unique
      errors.add(:item_relations, 'You have duplicate items listed.')
    end
  end

  def mark_empty_collaborator_for_removal
    collaborators.each do |c|
      c.mark_for_destruction if c.user_id.nil?
    end
  end
end
