class Comment < ActiveRecord::Base
  attr_accessible :details, :user_id, :commentable_id, :items_attributes

  belongs_to :user
  belongs_to :commentable, polymorphic: true, counter_cache: true
  has_many :uploads, as: :uploadable
  has_many :notifications, as: :notifiable
  has_many :items, as: :itemable
  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true

  validates :details, :commentable_id, :user_id, presence: true

  before_save :search_and_add_items

  def commentable_creator
    commentable.try(:creator) || commentable.user
  end

  # Create items based on the urls in a commnet text
  def search_and_add_items
    temp_items = Array.new
    accession_numbers = self.details.scan(/\/\/[\w]+[.]qajarwomen.org\/[^\/]+\/items\/(\w+).html/).uniq.flatten
    accession_numbers.each do |num|
      temp_items.push(Item.new(collect_item_info(num)))
    end
    self.items = temp_items
  end

  def collect_item_info(num)
    json_data = open "http://api.searchbox.io/api-key/7a575ca5d7081da4cf55e748d46686e4/wwqi-search-dev/item/_search?q=#{num}"
    parsed_data = ActiveSupport::JSON.decode(json_data)
    if parsed_data["hits"]["total"] < 1

      # In case there is no item for the accession number
      return { name: "Not Found", thumbnail: "flag.png", accession_no: num, url: "http://www.qajarwomen.org/en/items/#{num}.html" }
    else

      # In case there is a hit for the accession number
      source = parsed_data["hits"]["hits"][0]["_source"]
      return { name: source["title_en"], thumbnail: source["thumbnail"], accession_no: source["accession_num"], url: source["url_en"] }
    end
  end
end
