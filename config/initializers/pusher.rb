# config/initializers/pusher.rb
require 'pusher'

Pusher.url = ENV["url"]
Pusher.logger = Rails.logger

Pusher.app_id = ENV["app_id"]
Pusher.key = ENV["key"]

Pusher.secret = ENV["secret"]



