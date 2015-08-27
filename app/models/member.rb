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
end
