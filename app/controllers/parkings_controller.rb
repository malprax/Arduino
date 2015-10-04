class ParkingsController < ApplicationController
  before_action :set_portal, only: [:angkat_portal_parkir, :turunkan_portal_parkir, :create]
  def new
    @portal_parkir_terangkat = params[:portal_parkir_terangkat]
  end

  def create 
    
    sedang_parkir = Billing.find_by_member_id(params[:member_park])
    # sedang_parkir = Billing.find_by(params[:current])
    if sedang_parkir && Billing.current
      @servoparkir.position = 100
      respond_to do |format|
        format.html { redirect_to new_parking_path(:portal_parkir_terangkat => true), notice: 'Anda Bisa Parkir Sekarang'}
      end  
    else
      @servoparkir.position = 0
      respond_to do |format|
        format.html { redirect_to new_parking_path(:portal_parkir_terangkat => false), notice: 'Anda Tidak Bisa Parkir!'}
      end  
    end
  end
  
  def angkat_portal_parkir
    @servoparkir.position = 0
    # sleep 0.5
    render :nothing => true
  end

  def turunkan_portal_parkir
    @servoparkir.position = 100
    # sleep 0.5
    render :nothing => true
  end
  
  private
  def set_portal
    @board = Dino::Board.new(Dino::TxRx.new)
    @servoparkir = Dino::Components::Servo.new(pin: 10, board: @board )
  end
end
