class Upload < ActiveRecord::Base
  attr_accessible :content, :content_cache
  mount_uploader :content, FileUploader

  belongs_to :uploadable, polymorphic: true
end
