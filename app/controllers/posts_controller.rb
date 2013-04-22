class PostsController < ApplicationController
  inherit_resources

  before_filter :authenticate_user!, except: [:index, :show]

  helper_method :resource_name

  def new
    @post = Post.new
    @post.items.build
    @post.collaborators.build
    new!
  end

  def show
    @post = "#{resource.type}Decorator".constantize.decorate(resource)
    show!
  end

  private

  def resource_name
    @resource_name ||= resource_class.name.underscore
  end

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
