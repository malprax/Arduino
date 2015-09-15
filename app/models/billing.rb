# require "../pdfs/parkir_pdf"
# == Schema Information
#
# Table name: billings
#
#  id         :integer          not null, primary key
#  member_id  :integer
#  time_in    :datetime
#  time_out   :datetime
#  duration   :datetime
#  price      :decimal(, )
#  comment    :string
#  expiration :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Billing < ActiveRecord::Base
  belongs_to :member
  belongs_to :report
  
  accepts_nested_attributes_for :report
  before_create :set_expiration_date
  before_create :set_parking
  
  
  # attr_accessor :check_nama

  
  # before_update :copy_to_reports
  default_scope   -> {order('time_in DESC')}
  scope :current, -> {where('time_out IS NULL').order('time_in DESC')}
  scope :complete, -> {where('time_out IS NOT NULL').order('time_out DESC')}  
  scope :today, -> {where('time_in >= ? AND time_in <= ?', Time.now.beginning_of_day, Time.now.end_of_day).order('time_out DESC')}
  scope :expiration_date, -> {where('expiration <= ?', Date.today )}
  scope :park, -> {where('number_park IS NULL')}
  
  validates_presence_of :time_in, :member, message: 'Tidak Kosong'
  # validates_presence_of :number_park, message: 'Parkir sudah penuh'
  validate :check_time_in_and_out
  validate :check_current_billing_in_use, on: :create
  validate :check_number_park, on: :create

  
  #jika sudah ada user yang keluar dan maka parkir dibuat untuk mengisi kekosongan 
  def check_number_park
    if Billing.current.size == 9
            errors.add(:number_park, "Parkir Sudah Full Silahkan Datang Kembali Lain Waktu")
    end
    # if self.number_park.nil? #&& Billing.complete.where(:number_park => nil).present?
#       errors.add(:number_park, "Parkir Sudah Full Silahkan Datang Kembali Lain Waktu")
#     end
  end
  def check_time_in_and_out
    if self.time_out.present?
      errors.add(:time_out, "Waktu Keluar Muncul Setelah Waktu Masuk") if self.time_out.present? && self.time_out < self.time_in
    end
  end
   
   #jika sudah ada user yang parkir dan belum keluar maka tidak dapat mebuat billing baru  
  def check_current_billing_in_use
    if Billing.current.where(:member_id => member_id).present? 
      errors.add(:base, 'Tidak Dapat Membuat Billing Baru Jika Ada Billing Sebelumnya Yang Belum Di Tutup')   
    end 
  end
  
  def stop!
    if self.time_out.nil?
      update_attributes(time_out: Time.now)#("#{self.time_out}".to_i - "#{self.time_in}".to_i))
      true
    else
      false
    end
  end
  
  def self.time_today
    sum = 0.0
    self.today.each {|e| sum += (e.time_out.nil ? Time.now : e.time_out) - e.time_in }
  end
  
  def set_expiration_date
    tomorrow = Date.today + 1.day
    self.expiration = tomorrow
  end
  
  
  def self.tomorrow
    @tomorrow = Date.today + 1.day
  end
  
  def self.copy_to_reports
    Billing.expiration_date.complete.find_each do |billing|
         Report.create(:date  => "#{billing.expiration}", :billing_id  => "#{billing.id}", :member_id  => "#{billing.member_id}", :time_in  => "#{billing.time_in}", :time_out  => "#{billing.time_out}", :duration  => "#{billing.duration}", :comment  => "#{billing.comment}", :price  => "#{billing.price}") 
         billing.destroy  
    end
  end
  
  def set_parking
    a = [1,2,3,4,5,6,7,8,9]
    b = Billing.current.pluck(:number_park)
    c = a - b
    self.number_park = c.first    
  end 
  
end
