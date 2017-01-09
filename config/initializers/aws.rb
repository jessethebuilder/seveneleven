if Rails.env.production?
  CarrierWave.configure do |c|
    c.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ID'],
      aws_secret_access_key: ENV['AWS_SECRET'],
      region: 'us-west-2'
    }

    c.fog_directory = ENV['AWS_BUCKET']
  end
end
