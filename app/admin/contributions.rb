ActiveAdmin.register Contribution do

  menu :priority => 5
  
  index do
    selectable_column
    column :id
    column "Creator Name" do |r|
      if r.creator_id && r.creator_id != 0
        User.where("id = ?", r.creator_id).first.fullname
      else
        "Anonymous"
      end
    end
    column :item_id
    column :details
    column :created_at
    default_actions
  end
  
  filter :item_id
  filter :user_fullname, :as => :string, :label => "Creator"
end
