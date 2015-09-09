require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/prawn_outputter'

class MemberPdf < Prawn::Document
  def initialize(member)
    super(top_margin: 2, left_margin: 2, :page_size  => 'LETTER')
    @member = member
    bounding_box([10, cursor], :width => 250, :height => 150) do
      header
    end
    # stroke do
#       stroke_color '000000'
#       line_width 1
      # stroke_horizontal_rule
      # move_down 3
      # stroke_vertical_line
    # end

    # move_down 2
    # line_items
#
#     alamat
#     line_items
#     telepon
#     line_items
#     barcode
#     line_items
    # catatan_penting
    # line_items
  end
  
  def header
    logo
    # universitas
    fakultas
    nama
    alamat
    telepon
    barcode
  end
  
  def logo
    logo = "#{Rails.root}/app/assets/images/logoeditupri.png"
    image "#{logo}", scale: 0.04, :at => [25, cursor-25]
  end
  def universitas
    text_box "UNIVERSITAS FAJAR", :at  => [10,cursor-14], :size  => 6, :style  => :bold
  end
    
  def fakultas
    text_box "FAKULTAS TEKNIK", :at  => [70,cursor-25], :size  => 6
  end
  def nama
    text_box "Nama   :   #{@member.name}".upcase, :at  => [70,cursor-35], :size  => 6#, :style  => :bold
  end
  
  
  def alamat
    text_box "Alamat  :   #{@member.address}".upcase, :at  => [70,cursor-45], :size  => 6#, :style  => :bold
  end
  
  def telepon
    text_box "No HP/TLP   :   #{@member.phone}".upcase, :at  => [70,cursor-55], :size  => 6#, :style  => :bold
  end
  
  def barcode
    # _barcode = Barby::Code128B.new(@member.id)
    barcode = Barby::PrawnOutputter.new(@member.barcode)
    barcode.annotate_pdf(self, :x => 170, :y => 80)
    # text_box "no telepon   :   #{ @barcodexpdf}"  :at  => [20,cursor]
    # text_box "#{ @barcodexpdf}"  :at  => [20,cursor]
  end
  
  def line_items
    move_down 10    
  end
  
  def catatan_penting
    text "Catatan Penting :"
  end  

end