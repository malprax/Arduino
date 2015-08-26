require 'dino'

board = Dino::Board.new(Dino::TxRx.new)
up_led = Dino::Components::Led.new(pin: 12, board: board)
down_led = Dino::Components::Led.new(pin: 2, board: board)

# [:on, :off].cycle do |switch|
#   led.send(switch)
#   sleep 0.5
# end

def blink(up_led, down_led)
  up_led.send(:on)
  sleep 0.1
  up_led.send(:off)
  sleep 0.1
  down_led.send(:on)
  sleep 0.1
  down_led.send(:off)
  sleep 0.1
end

require 'pusher'

Pusher.app_id = '122739'
Pusher.key = '429f0dfaaec2f4d689e8'
Pusher.secret = '808cd9f52d25422d41ec'



begin
  Arduino::Application.config.board = Dino::Board.new(Dino::TxRx.new)
  button = Dino::Components::Button.new(pin: 2, board: Arduino::Application.config.board)

  button.down do
    puts 'down'
    Pusher['button'].trigger!('down', { :some => 'data' })
  end

  button.up do
    puts 'up'
    Pusher['button'].trigger!('up', { :some => 'data' })
  end

rescue Dino::BoardNotFound
  puts 'The board is not connected'
end