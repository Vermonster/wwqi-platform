ActiveAdmin.register Comment, :as => "UserComment" do

  menu :priority => 4

  index do
    selectable_column
    column :id
    column :user_id
    column :commentable_id
    column :commentable_type
    column :details
    column :created_at
    default_actions
  end
  
  filter :user_id
  filter :commentable_type
  filter :created_at
  
end
