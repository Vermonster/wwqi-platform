class ContributionRequestDecorator < ContributionDecorator
  def header
    "#{creator.fullname} made a #{details} request for"
  end
end
