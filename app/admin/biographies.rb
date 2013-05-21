ActiveAdmin.register Biography do

  menu :parent => "Contributions"
  
  index do
    selectable_column
    column :id
    column "Creator" do |r|
      User.where("id = ?", r.creator_id).first.fullname
    end
    column :item_id
    column :created_at
    default_actions
  end
  
  filter :item_id
  filter :user_fullname, :as => :string, :label => "Creator"
    
end
