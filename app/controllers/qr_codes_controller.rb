require 'rqrcode_png'
class QrCodesController < ApplicationController
  def index
    @qr = RQRCode::QRCode.new("riskawati angraini").to_img.resize(60,60).to_data_url
    # puts RQRCode::QRCode.new("riskawati angraini").to_img.resize(200,200)
    # png = @qr.to_img                                             # returns an instance of ChunkyPNG
    # png.resize(90, 90).save("really_cool_qr_image.png")
    
     # qr = RQRCode::QRCode.new( 'my string to generate', :size => 4, :level => :h )
     # @png = qr.to_img.resize(90, 90).save("really_cool_qr_image.png")                                             # returns an instance of ChunkyPNG
    
  end
  
  
    
  
end


