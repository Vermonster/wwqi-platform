class PostsController < ApplicationController
  inherit_resources

  before_filter :authenticate_user!, except: [:index, :show]

  helper_method :resource_name

  def show
    @post = "#{resource.type}Decorator".constantize.decorate(resource)
    show!
  end

  def create
    @post = Post.new(params[:post])
    @post.creator = current_user

    if @post.save
      redirect_to post_path(@post), notice: "Thread was successfully posted."
    else
      render :new
    end
  end
    
  private

  def resource_name
    @resource_name ||= resource_class.name.underscore
  end

  def build_resource
    @post = Post.new
    @post.items.build
    @post.collaborators.build
    set_resource_ivar(@post)
  end

  def resource
    super.decorate
  end

  def scoped_collection
    end_of_association_chain.questions_and_discussions
  end

  def scoped_followings
    current_user.followed_questions_and_discussions
  end

  def collection
    get_collection_ivar || begin
      posts = if params[:followed] && current_user
                scoped_followings
              else
                scoped_collection
              end

      if params[:q].present?
        posts = posts.search_text(params[:q])
      end

      set_collection_ivar(posts.decorate)
    end
  end
end
