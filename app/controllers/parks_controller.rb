class ParksController < ApplicationController
  before_action :set_park, only: [:show, :edit, :update, :destroy]
  before_action :set_servo, only: [:angkat_portal_parkir1, :turunkan_portal_parkir1, :create]

  # GET /parks
  # GET /parks.json
  def index
    @parks = Park.all
  end

  # GET /parks/1
  # GET /parks/1.json
  def show
    @portal_terangkat = params[:portal_terangkat]
    respond_to do |format|
      format.html
      # format.js
      # format.json{render json: @billing}
    end
  end

  # GET /parks/new
  def new
    @park = Park.new
  end

  # GET /parks/1/edit
  def edit
  end

  # POST /parks
  # POST /parks.json
  def create
    @park = Park.new(park_params)

    respond_to do |format|
      if @park.save
        @servoparkir1.position = 0
        format.html { redirect_to park_path(@park, :portal_terangkat => true), notice: 'Park was successfully created.' }
        # format.html { render new_parks_path(:portal_terangkat => true) , notice: 'Anda Berhasil Parkir.' }
        format.json { render :show, status: :created, location: @park }
      else
        @servoparkir1.position = 100
        format.html { render :new, :portal_terangkat => false }
        # format.html { render new_parks_path(:portal_terangkat => false) , notice: 'Anda Tidak Berhasil Parkir.' }
        format.json { render json: @park.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parks/1
  # PATCH/PUT /parks/1.json
  def update
    respond_to do |format|
      if @park.update(park_params)
        format.html { redirect_to @park, notice: 'Park was successfully updated.' }
        format.json { render :show, status: :ok, location: @park }
      else
        format.html { render :edit }
        format.json { render json: @park.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parks/1
  # DELETE /parks/1.json
  def destroy
    @park.destroy
    respond_to do |format|
      format.html { redirect_to parks_url, notice: 'Park was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def angkat_portal_parkir1
    @servoparkir1.position = 0
    sleep 0.1
    render :nothing => true
  end

  def turunkan_portal_parkir1
    @servoparkir1.position = 100
    sleep 0.1
    render :nothing => true
  end
  
  private
  def set_servo
    @board = Dino::Board.new(Dino::TxRx.new)
    @servoparkir1 = Dino::Components::Servo.new(pin: 10, board: @board )
    # @servoparkir2 = Dino::Components::Servo.new(pin: 2, board: @board )
 #    @servoparkir3 = Dino::Components::Servo.new(pin: 3, board: @board )
 #    @servoparkir4 = Dino::Components::Servo.new(pin: 4, board: @board )
 #    @servoparkir5 = Dino::Components::Servo.new(pin: 5, board: @board )
 #    @servoparkir6 = Dino::Components::Servo.new(pin: 6, board: @board )
 #    @servoparkir7 = Dino::Components::Servo.new(pin: 7, board: @board )
 #    @servoparkir8 = Dino::Components::Servo.new(pin: 8, board: @board )
 #    @servoparkir9 = Dino::Components::Servo.new(pin: 9, board: @board )
  end
  
  # Use callbacks to share common setup or constraints between actions.
  def set_park
    @park = Park.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def park_params
    params.require(:park).permit(:number, :billing_id, :billings_attributes => [])
  end
end
