class PostsController < ApplicationController
  inherit_resources

  before_filter :authenticate_user!, except: [:index, :show]

  private

  def create_resource(object)
    object.creator = current_user
    object.save
  end

  def resource
    super.decorate
  end

  def collection
    get_collection_ivar || begin
      posts = if params[:followed] && current_user
                current_user.followed_researches
              else
                end_of_association_chain
              end

      if params[:q].present?
        posts = posts.search_text(params[:q])
      end

      set_collection_ivar(posts.decorate)
    end
  end
end
