ActiveAdmin.register Transcription do

  menu :parent => "Contributions"
  decorate_with TranscriptionDecorator
  
  index do
    selectable_column
    column "Creator Name" do |r|
      User.where("id = ?", r.creator_id).first.fullname
    end
    column "Thumbnail" do |r|
      image_tag(r.item.thumbnail, size: "100x100")
    end
    column("Item") { |r| r.item.accession_no }
    column :title
    column :created_at
    default_actions
  end
  
  filter :title
  filter :user_fullname, :as => :string, :label => "Creator"
  
end
