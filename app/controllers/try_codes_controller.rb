class TryCodesController < ApplicationController
  # def index
#     @trycodes = Trycode.all
#
#   end
  def new
  end

  def create
    @trycodes = RQRCode::QRCode.new(try_code_params[:text], size: 4)
  end
  
  
  private
  def try_code_params
    params.require(:try_code).permit(:text)
  end
end
