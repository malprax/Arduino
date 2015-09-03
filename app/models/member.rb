require 'barby'
require 'barby/barcode/ean_13'
require 'barby/barcode/code_39'
require 'barby/barcode/code_128'

# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :string
#  phone      :string
#  barcode    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Member < ActiveRecord::Base
  validates :name, format: { with: /\A[a-zA-Z]+\z/, message: "Nama Depan/Panggilan Dengan Huruf Saja" }, length: { minimum: 3, message: "Nama Terlalu Pendek"  }
  validates :address, length: { minimum: 4, message: "Alamat Terlalu Pendek" }
  validates :phone, numericality: { only_integer: true, message: "Masukkan Hanya Angka Saja" }, length: { minimum: 10, message: "No Telepon Terlalu Pendek" }
  has_many :billings
  has_many :reports, through: :billings
  
  def barcode
    @barcode = Barby::Code128B.new(self.id)
  end
  
  private
    def self.search(query)
        where("lower(name) like lower(?) or phone like ? ", "%#{query}%", "%#{query}%") 
    end 
  
end
