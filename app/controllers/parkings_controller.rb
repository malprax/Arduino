class ParkingsController < ApplicationController
  before_action :set_portal, only: [:angkat_portal_parkir, :turunkan_portal_parkir, :create]
  def new
  end

  def create
    @portal_parkir_terangkat = params[:portal_parkir_terangkat]
    sedang_parkir = Billing.find_by_number_park(params[:number_park])
    if sedang_parkir 
      @servoparkir.position = 0
      respond_to do |format|
        format.html { redirect_to new_parking_path(:portal_parkir_terangkat => true)}
      end  
    else
      @servoparkir.position = 100
    end
  end
  
  def angkat_portal_parkir
    @servoparkir.position = 0
    sleep 0.5
    render :nothing => true
  end

  def turunkan_portal_parkir
    @servoparkir.position = 100
    sleep 0.5
    render :nothing => true
  end
  
  private
  def set_portal
    @board = Dino::Board.new(Dino::TxRx.new)
    @servoparkir = Dino::Components::Servo.new(pin: 10, board: @board )
  end
end
