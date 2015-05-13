# Capistrano::Bearychat

Send notifications to [Bearychat](https://bearychat.com) about [Capistrano v3](http://www.capistranorb.com) deployments. Inspired by [slackistrano](https://github.com/supremegolf/slackistrano).

## Requirements

- Capistrano >= 3.1.0
- Ruby >= 2.0
- A Bearychat account

## Installation

Add this line to your application's Gemfile:

    gem "capistrano",  "~> 3.1"
    gem "capistrano-bearychat", require: false

And then execute:

    $ bundle

## Configuration

To notify a channel in Bearychat when you deploy, Using *Incoming WebHooks* integration, offering more options but requires one of the five free integrations.

You need to enable the integration inside Bearychat and get the incoming webhook url that will be needed later.

Require the library in your application's Capfile:

    require 'capistrano/bearychat'

You need to set your webhook url in your application's config/deploy.rb:

    set :bearychat_webhook, "https://hook.bearychat.com/XXXX/XXX/XXXXX"

Optionally, override the other settings:

    set :bearychat_channel,          -> { '#general' }
    set :bearychat_using_markdown,   ->{ false } # Set to true to treat text as markdown.
    set :bearychat_channel_starting, -> { nil } # Channel to post to. Optional. Defaults to :bearychat_channel.
    set :bearychat_channel_finished, -> { nil } # Channel to post to. Optional. Defaults to :bearychat_channel.
    set :bearychat_channel_failed,   -> { nil } # Channel to post to. Optional. Defaults to :bearychat_channel.
    set :bearychat_run_starting,     -> { true }
    set :bearychat_run_finished,     -> { true }
    set :bearychat_run_failed,       -> { true }
    set :bearychat_msg_starting,     -> { "#{ENV['USER'] || ENV['USERNAME']} has started deploying branch #{fetch :branch} of #{fetch :application} to #{fetch :rails_env, 'production'}" }
    set :bearychat_msg_finished,     -> { "#{ENV['USER'] || ENV['USERNAME']} has finished deploying branch #{fetch :branch} of #{fetch :application} to #{fetch :rails_env, 'production'}" }
    set :bearychat_msg_failed,       -> { "#{ENV['USER'] || ENV['USERNAME']} failed to deploy branch #{fetch :branch} of #{fetch :application} to #{fetch :rails_env, 'production'}" }

**Note**: You may wish to disable one of the notifications if another service (ex:
Honeybadger) also displays a deploy notification.

Test your setup by running:

    $ cap production bearychat:deploy:starting
    $ cap production bearychat:deploy:finished
    $ cap production bearychat:deploy:failed

## Usage

Deploy your application like normal and you should see messages in the channel
you specified.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
