class ContributionsController < ApplicationController
  inherit_resources
  respond_to :html
  before_filter :authenticate_user!, except: [:index, :show]

  def show
    @contribution = "#{resource.type}Decorator".constantize.decorate(resource)
    # @contribution.item = Item.find(@contribution.item_id)
    show!
  end

  def index
    # Recently created or updated contributions
    @contributions = Contribution.where('type =? AND created_at > ?', params[:type] ||= 'Transcription', 6.days.ago).decorate

    # All items for now. It will select the items that are selected by admin
    @items = Item.all
  end

  def new
    @contribution = "#{params[:type]}".titleize.constantize.new
    selected_item = Item.find(params[:item])
    @contribution.build_item_relation( {url: selected_item.url, name: selected_item.name, thumbnail: selected_item.thumbnail, accession_no: selected_item.accession_no} )
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
