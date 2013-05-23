ActiveAdmin.register Biography do

  menu :parent => "Contributions"
  decorate_with BiographyDecorator
  
  index do
    selectable_column
    column :id
    column "Creator" do |r|
      User.where("id = ?", r.creator_id).first.fullname
    end
    column :title
    column :created_at
    default_actions
  end
  
  filter :title
  filter :user_fullname, :as => :string, :label => "Creator"
end
