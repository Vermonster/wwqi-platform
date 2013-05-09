class TranscriptionDecorator < ContributionDecorator
  def header
    "#{creator.fullname} contributed a transcription for"
  end
end
