class ProfileController < ApplicationController

  def show
    @resources = case params[:type]
              when "threads"
                current_user.posts.questions_and_discussions.decorate(with: nil)
              when "researches"
                current_user.posts.researches.decorate
              when "contributions"
                current_user.contributions.decorate(with: nil)
              when 'collaborations'
                current_user.collaborations
              else
                latest = current_user.posts.decorate + current_user.contributions.decorate(with: nil)
              end
  end

  def notifications
    @notifications = current_user.notifications.decorate
  end
end
