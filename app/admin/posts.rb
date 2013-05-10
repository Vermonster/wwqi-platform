ActiveAdmin.register Post do
  
  menu :priority => 3
  
  index do
    selectable_column
    column :type
    column :title
    column :creator_id
    column :created_at
    default_actions
  end
  
  filter :title
  filter :creator_id
end
