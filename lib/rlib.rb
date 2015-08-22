require 'RMagick'
require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/rmagick_outputter'

class Rlabel < Magick::Image

  def initialize(width, height, dpi = 500)
    @dpi = dpi
    super *rationalize(width, height)
    @x_offset, @y_offset = 0, 0
    self.y_resolution = self.x_resolution = @dpi
  end

  def offset x, y
    return x + @x_offset, y + @y_offset
  end

  def add_offset x, y
    @x_offset += rationalize x
    @y_offset += rationalize y
  end

  def set_offset x, y
    @x_offset, @y_offset = rationalize x, y
  end

  def rationalize *args
    if args.length == 1
      (args.first * @dpi / 25.400).to_i
    else
      args.collect {|x| (x * @dpi / 25.400).to_i }
    end
  end

  def unrationalize *args
    if args.length == 1
      args.first *  25.400 / @dpi
    else
      args.collect {|x| x * 25.400 / @dpi }
    end
  end

  def font_rationalize height
    ((height * @dpi - 1) / 18.19).to_i + 1
  end

  def add_picture picture_route, dim_hash, x, y
    width = dim_hash[:width]
    height = dim_hash[:height]
    x, y = rationalize x, y
    x, y = offset x, y
    expert_logo = Magick::ImageList.new(picture_route).first
    if width
      width = rationalize width
      ratio = width / expert_logo.columns.to_f
    elsif height
      height = rationalize height
      ratio = height / expert_logo.rows.to_f
    else
      raise 'No dimension given'
    end
    expert_logo.resize!(ratio)
    composite!(expert_logo, x, y, Magick::OverCompositeOp)
  end

  def add_barcode_image barcode_value, xmin, height, x, y, *options
    options = options.first || {}
    xmin, height, x, y = rationalize xmin, height, x, y
    x, y = offset x, y
    max_width = rationalize options[:max_width] if options[:max_width]
    barbycode = Barby::Code128A.new(barcode_value)
    case options[:code]
    when :b
      Barby::Code128A.new(barcode_value)
    when :c
      Barby::Code128A.new(barcode_value)
    else
      Barby::Code128A.new(barcode_value)
    end

    barby_img = Barby::RmagickOutputter.new(barbycode).to_image(xdim: xmin, height: height)
    barby_img.resize!(max_width, height) if max_width && max_width < barby_img.columns
    composite!(barby_img, x - (barby_img.columns/2), y, Magick::OverCompositeOp)
    barby_width, barby_height = unrationalize barby_img.columns, barby_img.rows
    barby_img.destroy!
    return barby_width, barby_height
  end

  def add_vertical_text x, y, text, fontsize, invert = false, *options
    x, y = rationalize x, y
    x, y = offset x, y
    text_color = "#000000"
    p = Magick::Draw.new
    p.pointsize = font_rationalize fontsize
    p.align = Magick::LeftAlign
    p.font_family = 'Helvetica'
    p.stroke = 'transparent'
    metrics = p.get_type_metrics(self, text)
    p.rotation = invert ? 270 : 90
    x = x - metrics[:height] unless invert
    p.annotate(self, 0, 0, x, y, text) {
      self.font_family = 'Helvetica'
      self.fill = text_color
    }
    unrationalize (x - @x_offset)
  end

  def add_condensed_text x, y, text, fontsize, width, *options
    options = options.first || {}
    x, y, width = rationalize x, y, width
    x, y = offset x, y
    p = Magick::Draw.new
    p.pointsize = font_rationalize fontsize
    p.stroke = 'transparent'
    p.font = "#{Rails.root}/lib/assets/monaco.ttf" if options[:font] == :monaco
    p.fill = "#000000"
    metrics = p.get_type_metrics(self, text)
    im = Magick::Image.new(metrics[:width], metrics[:ascent] - metrics[:descent]) {|i| i.background_color= "Transparent"}
    p.annotate(im, 0, 0, 0, metrics[:ascent], text)
    im.resize!(width,im.rows) if metrics[:width] > width
    new_x = case options[:align]
    when :center
      x - im.columns/2
    when :right
      x - im.columns
    else
      x
    end
    composite!(im, new_x, y, Magick::OverCompositeOp)
    unrationalize y + metrics[:height] - @y_offset
  end

  def add_text x, y, text, fontsize, *options
    options = options.first || {}
    x,y = rationalize x,y
    x, y = offset x, y
    text_color = "#000000"
    p = Magick::Draw.new
    p.pointsize = font_rationalize fontsize
    p.align = case options[:align]
    when :center
      Magick::CenterAlign
    when :right
      Magick::RightAlign
    else
      Magick::LeftAlign
    end
    p.font_weight = case options[:font_weight]
    when :bold
      Magick::BoldWeight
    else
      Magick::NormalWeight
    end
    p.font_family = 'Helvetica'
    p.stroke = 'transparent'
    metrics = p.get_type_metrics(self, text)
    p.annotate(self, 0, 0, x, y + metrics[:height], text) {
      self.font_family = 'Helvetica'
      self.fill = text_color
    }
    unrationalize (metrics[:height] + y - @y_offset)
  end

  def add_rect x1,y1,x2,y2, *options
    options = options.first || {}
    stroke_width = options[:stroke_width] || 0.2
    if options[:style] == :inner
      x1, y1, x2, y2 = x1 + stroke_width / 2.0, y1 + stroke_width / 2.0, x2 - stroke_width / 2.0, y2 - stroke_width / 2.0
    end
    x1, y1, x2, y2 = rationalize x1, y1, x2, y2
    x1, y1 = offset x1, y1
    x2, y2 = offset x2, y2
    p = Magick::Draw.new
    p.stroke('#000000')
    p.stroke_width(rationalize(stroke_width))
    p.stroke_dashoffset(rationalize(stroke_width))
    p.fill_opacity('0.0')
    p.stroke_opacity('1.0')
    p.rectangle(x1,y1,x2,y2)
    p.draw(self)
  end

  def add_line x1, y1, x2, y2, stroke_weight = 0.2
    x1, y1, x2, y2, stroke_weight = rationalize x1, y1, x2, y2, stroke_weight
    x1, y1 = offset x1, y1
    x2, y2 = offset x2, y2
    p = Magick::Draw.new
    p.stroke('#000000')
    p.stroke_width(stroke_weight)
    p.stroke_opacity('1.0')
    p.line(x1, y1, x2, y2)
    p.draw(self)
  end
end