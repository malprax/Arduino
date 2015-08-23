# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :string
#  phone      :string
#  rqr_code   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
