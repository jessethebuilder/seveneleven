# if Rails.env.production?
  CarrierWave.configure do |c|
    c.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ID'],
      aws_secret_access_key: ENV['AWS_SECRET'],
      region: ENV['AWS_REGION']
    }

    c.fog_directory = ENV['AWS_BUCKET']
  end
# end

Aws.config.update({
  region: ENV['AWS_REGION'],
  credentials: Aws::Credentials.new(ENV['AWS_ID'], ENV['AWS_SECRET']),
})

S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['AWS_BUCKET'])
