class CorrectionDecorator < ContributionDecorator
  def header
    "#{creator.first_name} contributed a correction for"
  end
end
