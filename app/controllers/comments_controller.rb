class CommentsController < ApplicationController
  inherit_resources
  respond_to :html
  belongs_to :post, :contribution, polymorphic: true

  def create
    @comment = Comment.new(params[:comment])
    @comment.commentable = parent
    @comment.user = current_user

    create! do |success, failure|
      success.html { redirect_to parent_type == :post ? post_path(parent) : contribution_path(parent) }
      failure.html { redirect_to parent_type == :post ? post_path(parent) : contribution_path(parent) }
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    render :edit
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      respond_with @comment do |format|
        format.html { redirect_to parent_type == :post ? post_path(parent) : contribution_path(parent), notice: "Updated successfully" }
      end
    else
      respond_with @comment do |format|
        format.html { render :edit }
      end
    end
  end
end
