require "net/http"
require "json"

load File.expand_path("../tasks/bearychat.rake", __FILE__)

module Capistrano
  module Bearychat
    extend self

    def post(webhook, payload: {})
      if webhook.nil?
        raise ArgumentError, "Please set bearychat_webhook in your deploy.rb file"
      end
      Net::HTTP.post_form(URI(webhook), "payload" => payload.to_json)
    rescue => e
      puts "There was an error notifying Bearychat."
      puts e.inspect
    end
  end
end
