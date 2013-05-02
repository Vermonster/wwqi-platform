class ContributionsController < ApplicationController
  inherit_resources
  respond_to :html
  before_filter :authenticate_user!, except: [:index, :show]

  def show
    @contribution = "#{resource.type}Decorator".constantize.decorate(resource)
    show!
  end

  def create
    @contribution = Contribution.new(params[:contribution].merge(
      creator_id: current_user.id))

    if @contribution.save
      redirect_to contribution_path(@contribution), 
        notice: "Your contribution was successfully submitted."
      return
    else
      render :new
      return
    end
  end

  private

  def collection
    # see https://github.com/drapergem/draper/issues/468
    # to view the explanation for `decorate(with: nil)`
    @contributions ||= end_of_association_chain.decorate(with: nil)
  end
end
