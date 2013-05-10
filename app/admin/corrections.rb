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
    column :creator_id
    column :item_id
    column :details
    column :created_at
    default_actions
  end
  
  filter :item_id
  filter :creator_id
  
end
