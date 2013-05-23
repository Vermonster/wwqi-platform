ActiveAdmin.register Post do
  
  menu :priority => 3, :label => 'Threads'
  
  index do
    selectable_column
    column :type
    column :title
    column "Created By" do |p|
      p.creator.fullname
    end
    column :created_at
    default_actions
  end
  
  filter :title
  filter :user_fullname, :as => :string, :label => "Creator"
end
