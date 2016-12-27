require 'rake/dsl_definition'
require 'rake'
require 'sidekiq'
require 'sidekiq-unique-jobs'

Sidekiq.configure_client do |config|
  config.redis = {url: ENV["REDISCLOUD_URL"] }
end

namespace :heroku_sidekiq do
  desc "Schedule a sidekiq Job with parameters. Usage: rake 'heroku_sidekiq:schedule_job[JobClassName,param1,param2]'. All parameters are considered strings."

  task :schedule_job, [:job] do |task, args|

    Object.const_set args[:job], Class.new 
    args[:job].constantize.class_eval do
      include Sidekiq::Worker
      sidekiq_options unique: :until_and_while_executing, retry: false
      def perform ; end
    end

    Sidekiq::Client.push 'class' => args[:job].constantize, 'args' => args.extras
  end
end