# config/initializers/pusher.rb
require 'pusher'

Pusher.app_id = '122740'
Pusher.key = '6a97661ed61a198a18cf'
Pusher.secret = 'bd808ec7f68f4ec890a2'
Pusher.url = "https://6a97661ed61a198a18cf:bd808ec7f68f4ec890a2@api.pusherapp.com/apps/122740"
Pusher.logger = Rails.logger
