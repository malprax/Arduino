require 'dino'
require 'pusher'
pusher = YAML.load_file(File.join(Arduino::Application.root, 'config/pusher.yml'))

Pusher.app_id = pusher['app_id']
Pusher.key = pusher['key']
Pusher.secret = pusher['secret']

begin

  Arduino::Application.config.board = Dino::Board.new(Dino::TxRx.new)
  button = Dino::Components::Button.new(pin: 13, board: Arduino::Application.config.board)
  # button = Dino::Components::Button.new(pin: 13, board: Arduino::Application.config.board)

  button.down do
    puts 'down'
    Pusher['button'].trigger!('down', { :some => 'data' })
   
    sleep
  end

  button.up do
    puts 'up'
    Pusher['button'].trigger!('up', { :some => 'data' })
  
    sleep
    
  end
  
rescue Dino::BoardNotFound
  puts 'The board is not connected'
end