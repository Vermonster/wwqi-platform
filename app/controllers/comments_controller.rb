class CommentsController < ApplicationController
  inherit_resources
  respond_to :html
  belongs_to :post

  def create
    @comment = Comment.new(params[:comment])
    @comment.commentable = parent
    @comment.user = current_user

    create! do |success, failure|
      success.html { redirect_to parent_path(parent) }
      failure.html { redirect_to parent_path(parent) }
    end
  end
end
