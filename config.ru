require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = {url: ENV["REDISCLOUD_URL"] }
end

require 'sidekiq/web'
run Sidekiq::Web