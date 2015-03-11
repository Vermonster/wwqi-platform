class Contribution < ActiveRecord::Base
  include AssociateItems

  paginates_per 5

  attr_accessible :details, :uploads_attributes, :item_relation_attributes,
                  :creator_id, :type, :item_attributes, :person_url, :person_name

  has_one :item_relation, as: :itemable, dependent: :destroy
  has_one :item, through: :item_relation
  accepts_nested_attributes_for :item_relation

  belongs_to :creator, class_name: 'User'
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :uploads, as: :uploadable, dependent: :destroy
  has_many :followings, as: :followable, dependent: :destroy
  has_many :followers, through: :followings, class_name: :User

  validates :details, presence: true
  validates :creator_id, :presence => true, :unless => Proc.new {|contribution| contribution.type == "Correction"}

  accepts_nested_attributes_for :uploads, allow_destroy: true, reject_if: :all_blank

  search_methods :user_fullname_contains

  scope :user_fullname_contains, lambda { |str|
    User.joins(:creator).where("LOWER(first_name) = LOWER(?) OR LOWER(last_name) = LOWER(?)", str, str)
  }

  def title
    item.try(:name) || item_relation.try(:name)
  end

  delegate :accession_no, :thumbnail, :wwqi_url, to: :item, allow_nil: true

  default_scope order('created_at DESC')

  after_create do |contribution|
    if ENV['ADMIN_NOTIFICATION_EMAIL']
      AdminNotificationMailer.new_contribution(contribution).deliver
    end
  end
end
