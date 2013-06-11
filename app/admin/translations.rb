ActiveAdmin.register Translation do

  menu :parent => "Contributions"
  decorate_with TranslationDecorator

  index do
    selectable_column
    column "Creator Name" do |r|
      User.where("id = ?", r.creator_id).first.fullname
    end
    column "thumbnail" do |r|
      image_tag(r.item.thumbnail, size: "100x100")
    end
    column :title
    column :created_at
    default_actions
  end
  
  filter :title
  filter :user_fullname, :as => :string, :label => "Creator"
  
end
