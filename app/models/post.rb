class Post < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :creator, class_name: :User
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :uploads, as: :uploadable, dependent: :destroy
  has_many :followings, as: :followable, dependent: :destroy
  has_many :followers, through: :followings, class_name: :User
  has_many :items, dependent: :destroy
  has_many :collaborators, dependent: :destroy

  attr_accessible :title, :details, :item_related, :private, :creator_id, :type, :tag_list, :uploads_attributes, :items_attributes, :collaborators_attributes

  validates :title, :details, :creator_id, presence: true
  validate :collaborator_duplication

  accepts_nested_attributes_for :uploads, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :items, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :collaborators, :reject_if => :all_blank, :allow_destroy => true

  default_scope order('created_at DESC')

  include PgSearch
  pg_search_scope :search_text, against: [:title, :details],
    associated_against: { tags: [:name] }

  private

  def collaborator_duplication

    num_of_unique = self.collaborators.map{ |i| i.user_id }.uniq.length

    if self.collaborators.length != num_of_unique 
      errors.add(:collaborator, 'One or more recipients are added more than once.')
    end
  end

end
