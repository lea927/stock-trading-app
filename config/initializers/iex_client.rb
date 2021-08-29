Configure IEX::Api.configure do |config|
  config.publishable_token =  ENV['IEX_API_PUBLISHABLE_TOKEN']
  config.endpoint = 'https://cloud.iexapis.com/v1'
end