class ContributionRequestDecorator < ContributionDecorator
  def header
    "#{creator.fullname} made a #{details} for "
  end

  def title
    item.name
  end
end
