class Upload < ActiveRecord::Base
  attr_accessible :content, :content_cache
  mount_uploader :content, FileUploader

  belongs_to :uploadable, polymorphic: true

  validates :content, file_size: { maximum: 2.megabytes.to_i }
end
