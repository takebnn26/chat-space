CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['SECRET_ACCESS_KEY'],
    region: 'us-east-1'
  }

    case Rails.env
    when 'development'
      config.fog_directory = 'upload-chatspace'
      config.asset_host = 'https://s3.amazonaws.com/upload-chatspace'
    when 'production'
      config.fog_directory = 'upload-chatspace'
      config.assert_host = 'https://s3.amazonaws.com/upload-chatspace'
    end
end
