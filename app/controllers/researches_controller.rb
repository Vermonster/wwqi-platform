class ResearchesController < PostsController
  defaults resource_class: Research

  def create
    @research = Research.new(params[:research])
    @research.creator = current_user

    if @research.save
      redirect_to research_path(@research), notice: "Research was successfully posted."
    else
      render :new
    end
  end

  private

  def build_resource
    @research = Research.new
    @research.item_relations.build
    @research.collaborators.build
    set_resource_ivar(@research)
  end
 
  def scoped_collection
    end_of_association_chain
  end

  def scoped_followings
    current_user.followed_researches
  end
end
