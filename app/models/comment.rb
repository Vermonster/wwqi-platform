class Comment < ActiveRecord::Base
  include AssociateItems

  attr_accessible :details, :user_id, :commentable_id, :items_attributes

  belongs_to :user
  belongs_to :commentable, polymorphic: true, counter_cache: true
  has_many :uploads, as: :uploadable
  has_many :notifications, as: :notifiable
  has_many :item_relations, as: :itemable, dependent: :destroy
  has_many :items, through: :item_relations
  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true

  validates :details, :commentable_id, :user_id, presence: true

  before_item_association :search_and_add_items

  search_methods :user_fullname_contains

  scope :user_fullname_contains, lambda { |str|
    User.joins(:user).where("LOWER(first_name) = LOWER(?) OR LOWER(last_name) = LOWER(?)", str, str)
  }

  def commentable_creator
    commentable.try(:creator) || commentable.user
  end

  # Create items based on the urls in a comment text
  def search_and_add_items
    accession_numbers = self.details.scan(/\/\/[\w]+[.]qajarwomen.org\/[^\/]+\/items\/(\w+).html/).uniq.flatten
    if self.new_record?
      accession_numbers.each do |num|
        self.item_relations.build(collect_item_info(num))
      end
    else
      # convert to an array for safe use of `delete`
      irs = item_relations.all

      accession_numbers.each do |num|
        ir = irs.find {|ir| ir.accession_no == num}

        if ir
          irs.delete(ir)
          ir.update_attributes(collect_item_info(num))
        else
          self.item_relations.build(collect_item_info(num))
        end
      end
      irs.map(&:destroy)
    end
  end

  def collect_item_info(num)
    json_data = open "#{SEARCH_URL}?q=#{num}", http_basic_authentication: SEARCH_AUTH.split(':')
    parsed_data = ActiveSupport::JSON.decode(json_data)
    if parsed_data["hits"]["total"] < 1

      # In case there is no item for the accession number
      return { name: "Not Found", thumbnail: "flag.png", accession_no: num, url: "#{WWQI_SITE}/en/items/#{num}.html" }
    else

      # In case there is a hit for the accession number
      source = parsed_data["hits"]["hits"][0]["_source"]
      return { name: source["title_en"], thumbnail: source["thumbnail"], accession_no: source["accession_num"], url: source["url_en"] }
    end
  end
end
