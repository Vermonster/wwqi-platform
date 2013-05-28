class ContributionsController < ApplicationController
  inherit_resources
  respond_to :html
  before_filter :authenticate_user!, except: [:index, :show]

  def show
    @contribution = "#{resource.type}Decorator".constantize.decorate(resource)
    @contribution.item = Item.find(@contribution.item_id)
    show!
  end

  def index
    # Recently created or updated contributions
    @contributions = Contribution.where('type =?', params[:type] ||= 'transcription')

    # All items for now. It will select the items that are selected by admin
    @items = Item.all
  end

  def new
    @contribution = "#{params[:type]}".titleize.constantize.new
    @contribution.item = Item.find(params[:item])
  end

  def create
    @contribution = "#{params[:type]}".constantize.new(params["#{params[:type]}".downcase])
    @contribution.creator = current_user
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
