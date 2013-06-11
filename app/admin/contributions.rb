ActiveAdmin.register Contribution do

  menu :priority => 5
  decorate_with ContributionDecorator
  
  index do
    selectable_column
    column "Creator Name" do |r|
      if r.creator_id && r.creator_id != 0
        User.where("id = ?", r.creator_id).first.fullname
      else
        "Anonymous"
      end
    end
    column "thumbnail" do |r|
      image_tag(r.item.thumbnail, size: "100x100")
    end
    column :type
    column :title
    column :details
    column :created_at
    default_actions
  end
  
  form do |f|
    f.inputs "Contribution Request" do
      f.input :accession_number 
      f.input :type
      f.input :creator
    end
    f.actions
  end

  filter :title
  filter :user_fullname, :as => :string, :label => "Creator"

end
