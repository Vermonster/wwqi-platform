class PostsController < ApplicationController
  inherit_resources

  before_filter :authenticate_user!, except: [:index, :show]

  helper_method :resource_name

  def show
    @post = "#{resource.type}Decorator".constantize.decorate(resource)
    show!
  end

  def create
    # Check the upload files if there is an oversized file.
    # If there is, it removes it from the param and store the 
    # name of the file at the array
    unless params.empty? && params[:post][:uploads_attributes].empty?
      big_size_files = Array.new
      params[:post][:uploads_attributes].each do |key, upload|
        if upload[:content].size > 2.megabytes
          big_size_files.push upload[:content].original_filename
          params[:post][:uploads_attributes].delete key
        end
      end
    end

    @post = Post.new(params[:post])
    @post.creator = current_user

    # If the array has a item, it redirects to the new page with a 
    # notice telling there is one or more oversized file.
    # Oterwise, it validates parameters and saves.
    if big_size_files.empty?
      if @post.save
        redirect_to post_path(@post), notice: "Thread was successfully posted."
      else
        render :new
      end
    else
      flash[:alert] = "The following files are over 2MB: "
      big_size_files.each do |name|
        flash[:alert] << " [#{name}] "
      end
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

      
      decorated_posts = posts.decorate.select do |post|
        post.can_see?(current_user)
      end
      
      set_collection_ivar(decorated_posts)
    end
  end
end
