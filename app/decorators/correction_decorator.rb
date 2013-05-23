class CorrectionDecorator < ContributionDecorator
  def header
    if creator
      "#{creator.fullname} contributed a correction for"
    else
       "Anonymous contributed a correction for"
    end
  end
end
