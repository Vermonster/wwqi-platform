ActiveAdmin.register Correction do

  menu parent: "Contributions"
  decorate_with CorrectionDecorator

  batch_action :reject do |selection|
    Correction.find(selection).each do |c|
      if c.creator
        CorrectionMailer.rejection_email.deliver
      end
    end
    
    redirect_to '/admin/corrections', notice: "User notified."
  end

  index do
    selectable_column
    column "Submitted By" do |c|
      if c.creator 
        c.creator.fullname
      else
        "Anonymous"
      end
    end
    column "Thumbnail" do |r|
      safe_image_tag r.thumbnail, size: '100x100'
    end
    column :title
    column("Item") { |r| r.item.try(:accession_no) }
    column :details
    column :created_at
    default_actions
  end
  
  filter :title
  filter :user_fullname, as: :string, label: "Creator"
end
