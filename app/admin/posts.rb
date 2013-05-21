ActiveAdmin.register Post do
  
  menu :priority => 3
  
  index do
    selectable_column
    column :type
    column :title
    column "Creator Name" do |r|
      User.where("id = ?", r.creator_id).first.fullname
    end
    column :created_at
    default_actions
  end
  
  filter :title
  filter :user_fullname, :as => :string, :label => "Creator"

end
