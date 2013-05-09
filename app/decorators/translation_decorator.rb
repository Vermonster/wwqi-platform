class TranslationDecorator < ContributionDecorator
  def header
    "#{creator.fullname} contributed a translation for"
  end
end
