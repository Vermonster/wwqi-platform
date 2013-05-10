ActiveAdmin.register Transcription do

  menu :parent => "Contributions"
  
  index do
    selectable_column
    column :id
    column :creator_id
    column :item_id
    column :created_at
    default_actions
  end
  
  filter :item_id
  filter :creator_id
  
end
