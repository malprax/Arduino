require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/prawn_outputter'

class ParkirPdf < Prawn::Document
  def initialize(billing)
    super(top_margin: 2, left_margin: 2, :page_size  => 'LETTER')
    @billing = billing
    bounding_box([10, cursor], :width => 250, :height => 150) do
      header
    end
  
  end
  
  def header
    logo
    # universitas
    fakultas
    nama
    masuk
    nomor_parkir
  end
  
  def logo
    logo = "#{Rails.root}/app/assets/images/unifa.jpg"
    image "#{logo}", scale: 0.04, :at => [25, cursor-25]
  end
  def universitas
    text_box "UNIVERSITAS FAJAR", :at  => [10,cursor-14], :size  => 6, :style  => :bold
  end
    
  def fakultas
    text_box "FAKULTAS TEKNIK", :at  => [70,cursor-25], :size  => 6
  end
  def nama
    text_box "Nama   :   #{@billing.member.name}".upcase, :at  => [70,cursor-35], :size  => 6#, :style  => :bold
  end
  
  def masuk
    text_box "Waktu Masuk   :   #{@billing.time_in}".upcase, :at  => [70,cursor-45], :size  => 6#, :style  => :bold
  end
  
  def nomor_parkir
    text_box "Nomor Parkir   :   #{@billing.number_park}".upcase, :at  => [70,cursor-55], :size  => 6#, :style  => :bold
  end
  
  def keterangan
    text_box "Mohon Parkir Pada Nomor Parkir Yang Ada Di Karcis Ini"
  end
  
  def line_items
    move_down 10    
  end
  
  
end