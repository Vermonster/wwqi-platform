class TranslationDecorator < ContributionDecorator
  def header
    "#{creator.first_name} contributed a translation for"
  end
end
