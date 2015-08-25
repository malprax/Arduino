# config/initializers/pusher.rb
require 'pusher'

Pusher.url = Figaro.env.pusher_url
Pusher.logger = Rails.logger
Pusher.app_id = Figaro.env.pusher_app_id
Pusher.key = Figaro.env.pusher_key
Pusher.secret = Figaro.env.pusher_secret



