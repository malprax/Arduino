class LedController < ApplicationController
  before_action :set_up_led, only: [:on, :off]
  def index
  end
  
  def on
    @led.on
    render :nothing => true
  end
  
  def off
    @led.off
    render :nothing => true
  end
  
  private
  def set_up_led
    board = Arduino::Application.config.board
    @led = Dino::Components::Led.new(pin: 2, board: board )
  end
end
