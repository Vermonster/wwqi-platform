class BiographyDecorator < ContributionDecorator
  def header
    "#{creator.first_name} contributed a biography for"
  end
end
