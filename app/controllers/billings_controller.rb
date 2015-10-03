require "prawn"
class BillingsController < ApplicationController
  before_action :set_up_led, only: [:angkat_portal, :turunkan_portal, :create]
  before_action :set_billing, only: [ :show, :edit, :update, :destroy]

  # GET /billings
  # GET /billings.json
  def index
    # @portal_terangkat = params[:portal_terangkat]
    @billings = Billing.all.page(params[:page]).per_page(9)
    @billing = Billing.find(params[:id]) unless @Billings.nil?
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /billings/1
  # GET /billings/1.json
  def show
    @portal_terangkat = params[:portal_terangkat]
    respond_to do |format|
      format.html
      format.js
      # format.json{render json: @billing}
      format.pdf do
        send_data generate_pdf,
                              type: "application/pdf",
                              disposition: "inline",
                              filename: "#{@billing.id}.pdf"
      end
    end
  end

  # GET /billings/new
  def new
    @billing = Billing.new
  end
  
  

  # GET /billings/1/edit
  # def edit
#   end

  # POST /billings
  # POST /billings.json
  def create
    @billing = Billing.new(billing_params)
    respond_to do |format|
      # format.html { render :new }
      # format.json { render json: @billing.errors, status: :unprocessable_entity }
      if @billing.save
        @servo.position = 90
        # format.html { redirect_to billings_path(:portal_terangkat => true), notice: 'Billing Berhasil Dibuat.' }
        format.html { redirect_to billing_path(@billing, :portal_terangkat => true), notice: 'Billing Berhasil Dibuat.' }
        format.json { render :show, status: :created, location: @billing }
        # format.json { render :new }
        
      else
        @servo.position = 0
        format.html { render :new }
        format.json { render json: @billing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /billings/1
  # PATCH/PUT /billings/1.json
  # def update
#     respond_to do |format|
#       # if @billing.update_attributes(params[:time_in, :comment, :expiration])
#       if @billing.update(billing_params)
#         format.html { redirect_to @billing, notice: 'Billing was successfully updated.' }
#         # format.json { render :show, status: :ok, location: @billing }
#         format.json { render :new }
#       else
#         format.html { render :edit }
#         format.json { render json: @billing.errors, status: :unprocessable_entity }
#       end
#     end
#   end

  # DELETE /billings/1
  # DELETE /billings/1.json
  def destroy
    @billing.destroy
    respond_to do |format|
      format.html { redirect_to billings_url, notice: 'Billing Berhasil Dihapus.' }
      format.json { head :no_content }
    end
  end
  
  def stop
    @billing = Billing.find(params[:id])
    # @billing.stop!
    if @billing.stop!
      respond_to do |format|
        format.html {redirect_to @billing, notice: 'Billing stopped'}
        format.js
        format.json{render json: @billing}
      end
    else
      respond_to do |format|
        format.html {redirect_to billings_url, notice: 'Billing was already stopped'}
      end
    end
  end
  
  def angkat_portal
    @servo.position = 0
    sleep 0.5
    render :nothing => true
  end

  def turunkan_portal
    @servo.position = 100
    sleep 0.5
    render :nothing => true
  end
    
  # def pretty_duration
  #   parse_string =
  #       if self < 3600
  #           '%M:%S'
  #       else
  #           '%H:%M:%S'
  #       end
  #
  #   Time.at(self).utc.strftime(parse_string)
  # end
  
  def give_time
    @time = Time.now.strftime(" %H:%M:%S ")

    render :partial => 'shared/time_portion'
  end
  
  def durate
        @billing = Billing.find(params[:id])
        @selisih_waktu = Time.now - @billing.time_in
        @durate = @selisih_waktu.to_i.pretty_duration
        render :partial => 'shared/durate'
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    
    def generate_pdf
      pdf = ParkirPdf.new(@billing) 
      pdf.render 
    end
    
    def set_billing
      @billing = Billing.find(params[:id])
    end
    
    def set_up_led
      # Arduino::Application.config.board
      # Dino::Board.new(Dino::TxRx.new)
      
      @board = Dino::Board.new(Dino::TxRx.new)
            @servo = Dino::Components::Servo.new(pin: 12, board: @board )
            # @led = Dino::Components::Led.new(pin: 12, board: @board)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def billing_params
      params.require(:billing).permit(:member_id, :time_in, :time_out, :price, :comment, :duration, :expiration, :number_park, :reports_attributes => [:id, :date, :time_in, :time_out, :duration, :price, :comment, :member_id, :billing_id] )
    end
    
end
