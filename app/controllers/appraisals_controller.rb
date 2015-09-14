class AppraisalsController < ApplicationController
  before_action :set_appraisal, only: [:show, :edit, :update, :destroy]

  # GET /appraisals
  # GET /appraisals.json
  def index
    @appraisals = Appraisal.all
  end

  # GET /appraisals/1
  # GET /appraisals/1.json
  def show
  end

  # GET /appraisals/new
  def new
    @appraisal = Appraisal.new
  end

  # GET /appraisals/1/edit
  def edit
  end

  # POST /appraisals
  # POST /appraisals.json
  def create
    @appraisal = Appraisal.new(appraisal_params)

    respond_to do |format|
      if @appraisal.save
        format.html { redirect_to @appraisal, notice: 'Appraisal was successfully created.' }
        format.json { render :show, status: :created, location: @appraisal }
      else
        format.html { render :new }
        format.json { render json: @appraisal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appraisals/1
  # PATCH/PUT /appraisals/1.json
  def update
    respond_to do |format|
      if @appraisal.update(appraisal_params)
        format.html { redirect_to @appraisal, notice: 'Appraisal was successfully updated.' }
        format.json { render :show, status: :ok, location: @appraisal }
      else
        format.html { render :edit }
        format.json { render json: @appraisal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appraisals/1
  # DELETE /appraisals/1.json
  def destroy
    @appraisal.destroy
    respond_to do |format|
      format.html { redirect_to appraisals_url, notice: 'Appraisal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appraisal
      @appraisal = Appraisal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appraisal_params
      params.require(:appraisal).permit(:address, :land_wide, :land_price, :building_wide, :building_price, :appraisal, :comment)
    end
end
