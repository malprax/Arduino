require 'chunky_png'
require 'rmagick'
require 'barby'
require 'barby/barcode/ean_13'
require 'barby/barcode/code_39'
require 'barby/barcode/code_128'
require 'barby/barcode/qr_code'
require 'barby/outputter/ascii_outputter'
require 'barby/outputter/rmagick_outputter'
require 'barby/outputter/html_outputter'
require 'barby/outputter/png_outputter' 
require 'barby/outputter/pdfwriter_outputter'


class MembersController < ApplicationController
  before_action :set_member, only: [:edit, :update, :destroy]

  # GET /members
  # GET /members.json
  def index
    @members = Member.search(params[:search]).page(params[:page]).per_page(6)
  end

  # GET /members/1
  # GET /members/1.json
  def look
    @member = Member.find(params[:member_id])
    barcodex = Barby::HtmlOutputter.new(@member.barcode).to_html  
    # barcodexpdf.annotate_pdf(doc)
    @barcode_for = barcodex
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        # pdf = MemberPdf.new(@member)
        # send_data pdf.render,
        send_data generate_pdf,
                              type: "application/pdf",
                              disposition: "inline",
                              filename: "Form_#{@member.name}.pdf"
      end
    end
  end
  def show
    @member = Member.find(params[:id])
    # @barcode = Barby::Code128B.new(@member.id)
    barcodex = Barby::HtmlOutputter.new(@member.barcode).to_html  
    # barcodexpdf.annotate_pdf(doc)
    @barcode_for = barcodex
    respond_to do |format|
      format.html
      format.pdf do
        # pdf = MemberPdf.new(@member)
        # send_data pdf.render,
        send_data generate_pdf,
                              type: "application/pdf",
                              disposition: "inline",
                              filename: "Form_#{@member.name}.pdf"
      end
    end
  end

  # GET /members/new
  def new
    @member = Member.new
    
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)
    respond_to do |format|
      if @member.save
        format.html { redirect_to members_path, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to members_path, notice: 'Member Berhasil Diupdate.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def delete
    @member = Member.find(params[:member_id])
  end
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member Berhasil Dihapus.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def generate_pdf
      pdf = MemberPdf.new(@member)
      pdf.render
      # pdf.autoprint
    end
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:name, :address, :phone, :barcode)
    end
end
