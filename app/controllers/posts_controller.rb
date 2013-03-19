class PostsController < ApplicationController
  inherit_resources
  respond_to :html

  def show
    @post = resource.decorate
    show!
  end

  def create
    @post = select_type(params)
    create! { resource_url }
  end

  private

  def collection
    # see https://github.com/drapergem/draper/issues/468
    # to view the explanation for `decorate(with: nil)`
    @posts ||= begin
                 posts = if params[:followed]
                  current_user.followed_posts
                 else
                  end_of_association_chain
                 end

                 posts.decorate(with: nil)
               end
  end

  def select_type
    if params[:post]
      case params[:post][:type]
      when 'question'
        Question.new(params[:post])
      when 'discussion'
        Discussion.new(params[:post])
      end
    end
  end
end
