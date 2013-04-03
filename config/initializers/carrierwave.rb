s3_enabled = ENV['ENABLE_S3'].inquiry.true?

ENABLE_S3 = s3_enabled || Rails.env.production?

CarrierWave.configure do |config|
  config.storage = ENABLE_S3 ? :fog : :file

  if ENABLE_S3
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    }

    config.fog_directory = ENV['AWS_S3_BUCKET']
  end
end
