class ResearchesController < PostsController
  defaults resource_class: Research

  def build_resource
    @research = Research.new
    @research.items.build
    @research.collaborators.build
    set_resource_ivar(@research)
  end
end
