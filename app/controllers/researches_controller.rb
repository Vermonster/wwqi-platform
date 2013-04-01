class ResearchesController < ApplicationController
  inherit_resources
  respond_to :html
  before_filter :authenticate_user!, except: [:index, :show]

  def show
    @research = resource.decorate
    show!
  end

  def create
    @research = Research.new(params[:research].merge(creator_id: current_user.id)) 
    create!
  end

  private

  def collection
    @researches ||= begin
                      researches = if params[:followed] && current_user
                                     current_user.followed_researches
                                  else
                                    end_of_association_chain
                                  end
                      if params[:q].present?
                        researches = researches.search_text(params[:q])
                      end
                      researches.decorate
                    end
  end
end
