class CommentsController < ApplicationController
  inherit_resources
  respond_to :html
  belongs_to :post
end
