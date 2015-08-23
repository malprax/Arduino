require 'barby/barcode/code_39'
class User < ActiveRecord::Base
  include HasBarcode

    has_barcode :barcode,
      :outputter => :svg,
      :type => :code_39,
      :value => Proc.new { |p| p.number }

    def number
      self.name
    end
end
