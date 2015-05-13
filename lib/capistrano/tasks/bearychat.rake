namespace :bearychat do
  namespace :deploy do
    task :starting do
      if fetch(:bearychat_run_starting)
        run_locally do
          Capistrano::Bearychat.post(
            fetch(:bearychat_webhook),
            payload: {
              channel: fetch(:bearychat_channel_starting) || fetch(:bearychat_channel),
              text: fetch(:bearychat_msg_starting),
              using_markdown: fetch(:bearychat_using_markdown)
            }
          )
        end
      end
    end

    task :finished do
      if fetch(:bearychat_run_finished)
        run_locally do
          Capistrano::Bearychat.post(
            fetch(:bearychat_webhook),
            payload: {
              channel: fetch(:bearychat_channel_finished) || fetch(:bearychat_channel),
              text: fetch(:bearychat_msg_finished),
              using_markdown: fetch(:bearychat_using_markdown)
            }
          )
        end
      end
    end

    task :failed do
      if fetch(:bearychat_run_failed)
        run_locally do
          Capistrano::Bearychat.post(
            fetch(:bearychat_webhook),
            payload: {
              channel: fetch(:bearychat_channel_failed) || fetch(:bearychat_channel),
              text: fetch(:bearychat_msg_failed),
              using_markdown: fetch(:bearychat_using_markdown)
            }
          )
        end
      end
    end

  end
end

after 'deploy:starting', 'bearychat:deploy:starting'
after 'deploy:finished', 'bearychat:deploy:finished'
after 'deploy:failed',   'bearychat:deploy:failed'

namespace :load do
  task :defaults do
    set :bearychat_webhook,          ->{ nil } # Incoming WebHook URL.
    set :bearychat_using_markdown,   ->{ false } # Set to true to treat text as markdown.

    set :bearychat_channel,          -> { nil } # Channel to post to. Optional. Defaults to WebHook setting.
    set :bearychat_channel_starting, -> { nil } # Channel to post to. Optional. Defaults to :bearychat_channel.
    set :bearychat_channel_finished, -> { nil } # Channel to post to. Optional. Defaults to :bearychat_channel.
    set :bearychat_channel_failed,   -> { nil } # Channel to post to. Optional. Defaults to :bearychat_channel.
    set :bearychat_run_starting,     -> { true } # Set to false to disable starting message.
    set :bearychat_run_finished,     -> { true } # Set to false to disable finished message.
    set :bearychat_run_failed,       -> { true } # Set to false to disable failure message.
    set :bearychat_msg_starting,     -> { "#{ENV['USER'] || ENV['USERNAME']} has started deploying branch #{fetch :branch} of #{fetch :application} to #{fetch :stage, 'an unknown stage'}" }
    set :bearychat_msg_finished,     -> { "#{ENV['USER'] || ENV['USERNAME']} has finished deploying branch #{fetch :branch} of #{fetch :application} to #{fetch :stage, 'an unknown stage'}" }
    set :bearychat_msg_failed,       -> { "#{ENV['USER'] || ENV['USERNAME']} failed to deploy branch #{fetch :branch} of #{fetch :application} to #{fetch :stage, 'an unknown stage'}" }
  end
end
