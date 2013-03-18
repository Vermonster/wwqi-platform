class PostsController < ApplicationController
  inherit_resources
  respond_to :html

  def create
    @post = select_type(params)
    create! { resource_url }
  end

  private

  def collection
    # https://github.com/drapergem/draper/issues/468
    @posts ||= end_of_association_chain.decorate(with: nil)
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
