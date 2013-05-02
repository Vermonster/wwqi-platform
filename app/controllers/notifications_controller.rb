class NotificationsController < ApplicationController
  inherit_resources
  respond_to :html
  belongs_to :user

  def show
    resource.read!
    redirect_to target_path(resource.notifiable.commentable)
  end

  private

  def target_path(target)
    case target
    when Question, Discussion
      post_path(target)
    when Research
      research_path(target)
    end
  end
end
