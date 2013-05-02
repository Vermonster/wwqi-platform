class CorrectionsController < ContributionsController
  inherit_resources
  before_filter :authenticate_user!, except: [:index, :new, :create]

  def index

  end
  
  def new
    @correction = Correction.new
    new!
  end
  
  def create
    @correction = current_user ? Correction.new(params[:correction].merge(creator_id: current_user.id)) : Correction.new(params[:correction])
    
    if @correction.save
      if current_user
        redirect_to contribution_path(@correction), 
          notice: "Your correction was successfully submitted."
        return
      else
        redirect_to contributions_path,
          notice: "Your correction was successfully submitted."
        return
      end
    else
      render :new, notice: "Correction submission was not successful."
      return
    end
  end
  
  def show
    @correction = "#{resource.type}Decorator".constantize.decorate(resource)
    show!
  end
  
end
