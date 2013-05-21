ActiveAdmin.register Comment, :as => "UserComment" do

  menu :priority => 4

  index do
    selectable_column
    column :id
    column :commentable_id
    column :commentable_type
    column :details
    column "Creator" do |r|
      User.where("id = ?", r.user_id).first.fullname
    end
    column :created_at
    default_actions
  end
  
  filter :user_fullname, :as => :string, :label => "Creator"
  filter :commentable_type
  filter :created_at
  
end
