class Upload < ActiveRecord::Base
  attr_accessible :content
  mount_uploader :content, FileUploader

  belongs_to :uploadable, polymorphic: true
end
