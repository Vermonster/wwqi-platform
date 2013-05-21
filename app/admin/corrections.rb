ActiveAdmin.register Correction do

  menu :parent => "Contributions"

  batch_action :reject do |selection|
    Correction.find(selection).each do |c|
      if c.creator_id
        #User.find(c.creator_id) do
        CorrectionMailer.rejection_email.deliver
        #end
      end
    end
    
    redirect_to '/admin/corrections', :notice => "User notified."
  end

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
