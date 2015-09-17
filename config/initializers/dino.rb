require 'dino'
require 'pusher'
pusher = YAML.load_file(File.join(Arduino::Application.root, 'config/pusher.yml'))

# Pusher.app_id = '122739'
# Pusher.key = '429f0dfaaec2f4d689e8'
# Pusher.secret = '808cd9f52d25422d41ec'

# Pusher.app_id = '122740'
#     Pusher.key = '6a97661ed61a198a18cf'
#     Pusher.secret = 'bd808ec7f68f4ec890a2'
# Pusher.app_id = ENV['APP_ID']
# Pusher.key = ENV['APP_KEY']
# Pusher.secret = ENV['APP_SECRET']
# Pusher.app_id = 'APP_ID'
# Pusher.key = 'APP_KEY'
# Pusher.secret = 'APP_SECRET'


Pusher.app_id = pusher['app_id']
Pusher.key = pusher['key']
Pusher.secret = pusher['secret']

begin
  # board = Dino::Board.new(Dino::TxRx.new)
  Arduino::Application.config.board = Dino::Board.new(Dino::TxRx.new)
  button = Dino::Components::Button.new(pin: 13, board: Arduino::Application.config.board)
  # button = Dino::Components::Button.new(pin: 13, board: Arduino::Application.config.board)

  button.down do
    puts 'down'
    Pusher['button'].trigger!('down', { :some => 'data' })
    # button.trigger!('down', { :some => 'data' })
    
  end

  button.up do
    puts 'up'
    Pusher['button'].trigger!('up', { :some => 'data' })
    # button.trigger!('up', { :some => 'data' })
    
  end
  
rescue Dino::BoardNotFound
  puts 'The board is not connected'
end