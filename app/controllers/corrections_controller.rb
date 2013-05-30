class CorrectionsController < ContributionsController
  inherit_resources
  skip_before_filter :authenticate_user!
  defaults resource_class: Correction

  def create
    @correction = Correction.new(params[:correction])
    @correction.creator = current_user

    if @correction.save
      redirect_to contributions_path,
        notice: "Your correction was successfully submitted."
    else
      render :new, alert: "Submission was not successful."
    end
  end
  
  def new
    @correction = Correction.new
    @correction.build_item_relation
  end

  private

  def build_resource
    @correction = Correction.new
    @correction.build_item_relation
    set_resource_ivar(@correction)
  end
end
