ActiveAdmin.register Biography do

  menu :parent => "Contributions"
  decorate_with BiographyDecorator

  index do
    selectable_column
    column "Creator" do |r|
      User.where("id = ?", r.creator_id).first.fullname
    end
    column "Thumbnail" do |r|
      safe_image_tag r.thumbnail, size: '100x100'
    end
    column "Person" do |r|
      link_to r.title, r.wwqi_url, target: '_blank'
    end
    column :created_at
    default_actions
  end

  filter :title
  filter :user_fullname, :as => :string, :label => "Creator"
end
