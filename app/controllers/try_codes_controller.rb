# require 'rqrcode_png'
require 'chunky_png'
require 'RMagick'
# require 'rqrcode'
require 'barby'
require 'barby/barcode/ean_13'
require 'barby/barcode/code_39'
require 'barby/barcode/code_128'
require 'barby/barcode/qr_code'
require 'barby/outputter/ascii_outputter'
require 'barby/outputter/rmagick_outputter'
require 'barby/outputter/html_outputter'
require 'barby/outputter/png_outputter' 

class TryCodesController < ApplicationController
  def index
    # @qr = RQRCode::QRCode.new("riskawati angraini").to_img.resize(60,60).to_data_url
    @barcode = Barby::Code128B.new(try_code_params[:text])
    @barcode_for = Barby::HtmlOutputter.new(@barcode).to_html
     # barcode = Barby::QrCode.new("aulia")
     # @barcode = Barby::Code128B.new('0123124123')
     # @barcode = Barby::Code128B.new(try_code_params[:text])
     #@barcode.to_image(:height => 15, :margin => 5).to_data_url
      # barcode = Barby::EAN13.new('0123124123')
     #barcode = Barby::DataMatrix.new('0123124123')
     # @barcode_for = Barby::HtmlOutputter.new(@barcode).to_html
    # @barcode_for = Barby::AsciiOutputter.new(@barcode)
    #@barcode_for = Barby::PngOutputter.new(@barcode)
    #@outputter = Barby::PngOutputter.new(barcode)
     #File.open('barcode.png', 'w'){|f| f.write @barcode_for.to_png}
  end
  
  def new
    # @barcode = Barby::Code128B.new(try_code_params[:text])
    

  end

  def create
    @barcode = Barby::Code128B.new(try_code_params[:text])
    @barcode_for = Barby::HtmlOutputter.new(@barcode).to_html
    
  end
  
  
  private
  def try_code_params
    params.require(:try_code).permit(:text)
  end
end
