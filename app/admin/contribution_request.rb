ActiveAdmin.register ContributionRequest do
  decorate_with ContributionRequestDecorator
  menu parent: "Contributions", priority: 5

  index do
    selectable_column
    column :id
    column "Creator Name" do |r|
      User.where("id = ?", r.creator_id).first.fullname
    end

    column :details
    column :created_at
    default_actions
  end
  
  controller do
    def build_resource
      @contribution_request = ContributionRequest.new(params[:contribution_request])
      @contribution_request.build_item_relation unless @contribution_request.item_relation.present?
      @contribution_request
    end

    def create_resource(object)
      object.creator = current_user
      object.save
    end
  end

  show do |r|
    attributes_table do
      row :details
      row :creator
      row :image do
        image_tag(r.item.thumbnail)
      end
    end
    
  end

  form partial: "request"

  filter :type
  filter :accession_number
end
