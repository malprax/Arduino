# config/initializers/pusher.rb
require 'pusher'

Pusher.url = ENV["url"]
Pusher.logger = Rails.logger

