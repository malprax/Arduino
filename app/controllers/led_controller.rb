
class LedController < ApplicationController
  before_action :set_up_led, only: [:angkat_portal, :turunkan_portal]
  def index
  end
  
  
  def angkat_portal
    @led.off
    render :nothing => true
  end
  
  def turunkan_portal
    @led.on
    render :nothing => true
  end
  
  
  private
  def set_up_led
    board = Arduino::Aplication.config.board
    @led = Dino::Components::Led.new(pin: 12, board: board )
    # @led2 = Dino::Components::Led.new(pin: 12, board: board )
  end
end
