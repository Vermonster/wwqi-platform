class BiographyDecorator < ContributionDecorator
  def header
    "#{creator.fullname} contributed a biography for"
  end
end
