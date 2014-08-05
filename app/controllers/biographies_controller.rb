class BiographiesController < ContributionsController
  inherit_resources
  skip_before_filter :custom_authenticate_user!
  defaults resource_class: Biography

  def create
    @biography = Biography.new(params[:biography])
    @biography.creator = current_user

    if @biography.save
      redirect_to contributions_path,
        notice: "Your biography was successfully submitted."
    else
      render :new, alert: "Submission was not successful."
    end
  end

  def new
    @biography = Biography.new
    @biography.build_item_relation
  end

  private

  def build_resource
    @biography = Biography.new
    @biography.build_item_relation
    set_resource_ivar(@biography)
  end
end
