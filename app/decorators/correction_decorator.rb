class CorrectionDecorator < ContributionDecorator
  def header
    if creator
      "#{creator.first_name} contributed a correction for"
    else
       "Anonymous contributed a correction for"
    end
  end
  
  def title
    item_id
  end
end
