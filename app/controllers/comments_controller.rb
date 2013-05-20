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

  def edit
    @comment = Comment.find(params[:id])
    render :edit
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      respond_with @comment do |format|
        format.html { redirect_to parent_path(parent), notice: "Updated successfully" }
        format.json { head :no_content }
      end
    else
      respond_with @comment do |format|
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
end
