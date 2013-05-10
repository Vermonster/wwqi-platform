class FollowingsController < ApplicationController
  respond_to :json
  inherit_resources
  belongs_to :post, :research, :polymorphic => true

  def create_resource(object)
    object.user = current_user
    object.save
  end
end
