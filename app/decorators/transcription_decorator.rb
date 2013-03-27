class TranscriptionDecorator < ContributionDecorator
  def header
    "#{creator.first_name} contributed a transcription for"
  end
end
