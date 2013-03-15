class Upload < ActiveRecord::Base
  # attr_accessible :title, :body
  mount_uploader :content, FileUploader

  belongs_to :uploadable, polymorphic: true
end
