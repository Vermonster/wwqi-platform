class PostsController < ApplicationController
  inherit_resources
  respond_to :html
  before_filter :authenticate_user!, except: [:index, :show]

  def show
    @post = "#{resource.type}Decorator".constantize.decorate(resource)
    show!
  end

  def create
    @post = Post.new(params[:post].merge(creator_id: current_user.id))
    #create!(notice: "Thread was successfully created.") { resource_url }
    logger.debug "param is #{@post}"

    if @post.save
      redirect_to post_path(@post), notice: "Thread was successfully created."
    else
      render :new
    end
  end
  private

  def collection
    # see https://github.com/drapergem/draper/issues/468
    # to view the explanation for `decorate(with: nil)`
    @posts ||= begin
                 posts = if params[:followed] && current_user
                  current_user.followed_posts
                 else
                  end_of_association_chain
                 end

                  if params[:q].present?
                    posts = posts.search_text(params[:q])
                  end
                 posts.decorate(with: nil)
               end
  end
end
