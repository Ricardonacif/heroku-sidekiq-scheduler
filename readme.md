# Simple Solution for Sidekiq Recurring Jobs using Heroku

Cool, so you use Sidekiq for background jobs, and now you want need some recurring jobs. This is a simple hack for not having to manage a crontab process, specific server for that or whatever. You'll need:

1. Heroku account with a new heroku App
2. On this App, get a free redis instance (Rediscloud will do it)
3. Get also the Heroku Scheduler addon (why manage ourselves if we can trust Heroku for free?)
4. Deploy this project to heroku


Cool! Now all you need to do is create recurring rake tasks on Heroku Scheduler Dashboard like:
```ruby
bundle exec rake 'heroku_sidekiq:schedule_job[JobClassName,param1,param2]'
```

That simple :D Heroku Schedule will take care of enqueing the jobs, your workers will take care of executing it, and you'll never have to deal with this code/Heroku App anymore, since it doesn't need to know anything about your real code. Also, we're using [sidekiq-unique-jobs gem] (https://github.com/mhenrixon/sidekiq-unique-jobs) to make sure the job is unique.