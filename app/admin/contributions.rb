ActiveAdmin.register Contribution do

  menu :priority => 5
  decorate_with ContributionDecorator
  actions :all, except: [:edit]

  index do
    selectable_column
    column "Creator Name" do |r|
      if r.creator_id && r.creator_id != 0
        User.where("id = ?", r.creator_id).first.fullname
      else
        "Anonymous"
      end
    end
    column "Thumbnail" do |r|
      safe_image_tag r.thumbnail, size: '100x100'
    end
    column("Item") do |r|
      link_to r.title, r.wwqi_url, target: '_blank'
    end
    column :type
    column :details
    column :created_at
    default_actions
  end

  filter :title
  filter :user_fullname, :as => :string, :label => "Creator"

end
