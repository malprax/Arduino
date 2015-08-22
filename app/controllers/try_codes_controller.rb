require 'RMagick'
require 'rqrcode'
require 'barby'
require 'barby/barcode/code_128'
require 'barby/barcode/qr_code'
require 'barby/outputter/ascii_outputter'
require 'barby/outputter/rmagick_outputter'
require 'barby/outputter/html_outputter'
require 'barby/outputter/png_outputter' 

class TryCodesController < ApplicationController
  def index
    # barcode = Barby::QrCode.new("aulia")
     barcode = Barby::Code128B.new('0123456789')
    # @barcode_for = Barby::HtmlOutputter.new(@barcode).to_html
    @barcode_for = Barby::RmagickOutputter.new(barcode).to_image
    
    # @outputter = Barby::PngOutputter.new(barcode)
    
    
    # File.open('barcode.png', 'w'){|f| f.write @barcode_for }
    
    
    #@trycode.to_html
    # File.open('barcode.png', 'w') do |f|
 #      f.write @barcode_for.to_png
 #      f.close
 #    end
  end
  
  def new

  end

  def create
    # @trycodes = RQRCode::QRCode.new(try_code_params[:text], size: 0.25, level: :h)
    @trycode = Barby::Code128B.new('aulia')
    File.open('barcode.png', 'w') do |f|
      f.write @trycode.to_png
      f.close
    end
    # barcode.to_html
    # respond_to do |format|
#       format.html
#       format.png do
#         send_data @blob, type: "image/png", disposition: "inline"
#       end
#     end
    
    #@blob = Barby::PngOutputter.new(@barcode).to_png #Raw PNG data
    #File.open('barcode.png', 'w'){|f| f.write @blob }
    
  end
  
  
  private
  def try_code_params
    params.require(:try_code).permit(:text)
  end
end
