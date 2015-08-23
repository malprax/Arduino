class Member < ActiveRecord::Base
  validates :name, format: { with: /\A[a-zA-Z]+\z/, message: "Hanya Diperbolehkan Huruf Saja" }, length: { minimum: 3, message: "Nama Terlalu Pendek"  }
  validates :address, length: { minimum: 4, message: "Alamat Terlalu Pendek" }
  validates :phone, numericality: { only_integer: true, message: "Masukkan Hanya Angka Saja" }, length: { minimum: 10, message: "No Telepon Terlalu Pendek" }
end
