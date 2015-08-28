class BillingsController < ApplicationController
  before_action :set_up_led, only: [:angkat_portal, :turunkan_portal]
  before_action :set_billing, only: [:show, :edit, :update, :destroy]

  # GET /billings
  # GET /billings.json
  def index
    @billings = Billing.all
  end

  # GET /billings/1
  # GET /billings/1.json
  def show
  end

  # GET /billings/new
  def new
    @billing = Billing.new
  end

  # GET /billings/1/edit
  def edit
  end

  # POST /billings
  # POST /billings.json
  def create
    @billing = Billing.new(billing_params)
    respond_to do |format|
      if @billing.save
        format.html { redirect_to @billing, notice: 'Billing was successfully created.' }
        format.json { render :show, status: :created, location: @billing }
      else
        format.html { render :new }
        format.json { render json: @billing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /billings/1
  # PATCH/PUT /billings/1.json
  def update
    respond_to do |format|
      if @billing.update(billing_params)
        format.html { redirect_to @billing, notice: 'Billing was successfully updated.' }
        format.json { render :show, status: :ok, location: @billing }
      else
        format.html { render :edit }
        format.json { render json: @billing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /billings/1
  # DELETE /billings/1.json
  def destroy
    @billing.destroy
    respond_to do |format|
      format.html { redirect_to billings_url, notice: 'Billing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def stop
    @billing = Billing.find(params[:id])
    if @billing.stop!
      respond_to do |format|
        format.html {redirect_to(billings_url, notice: 'Billing stopped')}
      end
    else
      respond_to do |format|
        format.html {redirect_to(billings_url, notice: 'Billing was already stopped')}
      end
    end
  end
  
  # def current
#     render partial: 'billings/current', current_billings: current_billings
#   end

  def angkat_portal
    @led.off
    render :nothing => true
  end

  def turunkan_portal
    @led.on
    render :nothing => true
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_billing
      @billing = Billing.find(params[:id])
    end
    
    def set_up_led
      @board = Dino::Board.new(Dino::TxRx.new)
      @led = Dino::Components::Led.new(pin: 12, board: @board )
      # @led2 = Dino::Components::Led.new(pin: 12, board: board )
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def billing_params
      params.require(:billing).permit(:member_id, :time_in, :time_out, :price, :comment, :duration, :expiration, :reports_attributes => [:id, :date, :time_in, :time_out, :duration, :price, :comment, :member_id, :billing_id] )
    end
end
