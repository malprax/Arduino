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