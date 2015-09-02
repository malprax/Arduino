require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/prawn_outputter'

class MemberPdf < Prawn::Document
  def initialize(member)
    super(top_margin: 30, left_margin: 50, :page_size  => 'A4')
    @member = member
    bounding_box([10, cursor], :width => 500, :height => 84) do
      header
    end
    stroke do
      stroke_color '000000'
      line_width 1
      stroke_horizontal_rule
      move_down 3
      horizontal_line(0, 509)
    end
    
    move_down 10
    line_items
    nama
    line_items
    alamat
    line_items
    telepon
    line_items
    barcode
    line_items
    catatan_penting
    line_items

    
  
  end
  
  def header
    logo = "#{Rails.root}/app/assets/images/logoeditupri.png"
    image "#{logo}", scale: 0.08, :at => [0, cursor+14]

    text_box "YAYASAN PERGURUAN TINGGI KARYA DHARMA PUSAT MAKASSAR", :at  => [70,cursor], :size  => 10
  
    text_box "UNIVERSITAS PEJUANG REPUBLIK INDONESIA", :at  => [70,cursor-14], :size  => 12, :style  => :bold

    text_box "FAKULTAS TEKNIK", :at  => [70,cursor-30], :size  => 25, :style  => :bold
    text_box "Jurusan Teknik Pertambangan, Jurusan Teknik Mesin, Jurusan Teknik Informatika", :at  => [70,cursor-55], :size  => 8, :style  => :bold

    text_box "Jl. Baruga Raya - Antang Telp. (0411)492008 - Fax.(0411)494500 Ujung Pandang 90234", :at  => [70,cursor-64], :size  => 8, :style  => :bold

  end
  

  def nama
    text "nama                :   #{@member.name}".upcase
  end
  
  
  def alamat
    text "alamat            :   #{@member.address}".upcase
    move_down 10
  end
  
  def telepon
    text "no telepon   :   #{@member.phone}".upcase
    move_down 10
  
  end
  
  def barcode
    # _barcode = Barby::Code128B.new(@member.id)
    barcode = Barby::PrawnOutputter.new(@member.barcode)
    barcode.annotate_pdf(self, :x => 100, :y => 500)
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