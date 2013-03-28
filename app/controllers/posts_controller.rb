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
    if @post.save
      redirect_to post_path(@post), notice: "Thread was successfully created."
    else
      render :new
    end
  end
# for autocomplete
  def user_email=(email)
    user = User.find_by_email(email)
    if user
      self.user_id = user.id
    else
      errors[:user_email] << "Invalid name entered"
    end
  end

  def user_email
    User.find(user_id).fullname if user_id
  end
  # end fo autocomplete
  private

  def collection
    # see https://github.com/drapergem/draper/issues/468
    # to view the explanation for `decorate(with: nil)`
    @posts ||= begin
                 posts = if params[:followed] && current_user
                  current_user.followed_questions_and_discussions
                 else
                  end_of_association_chain.questions_and_discussions
                 end

                  if params[:q].present?
                    posts = posts.search_text(params[:q])
                  end
                 posts.decorate(with: nil)
               end
  end
end
