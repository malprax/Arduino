# == Schema Information
#
# Table name: billings
#
#  id         :integer          not null, primary key
#  member_id  :integer
#  time_in    :datetime
#  time_out   :datetime
#  price      :decimal(, )
#  comment    :string
#  expiration :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Billing < ActiveRecord::Base
  belongs_to :member
  has_many :reports
  accepts_nested_attributes_for :reports
  before_create :set_expiration_date
  before_destroy :copy_to_reports
  default_scope   -> {order('time_in DESC')}
  scope :current, -> {where('time_out IS NULL').order('time_in DESC')}
  scope :complete, -> {where('time_out IS NOT NULL').order('time_out DESC')}  
  scope :today, -> {where('time_in >= ? AND time_in <= ?', Time.now.beginning_of_day, Time.now.end_of_day)}
  
  validates_presence_of :time_in, :member, message: 'Tidak Kosong'
  validate :check_time_in_and_out
  # validate :only_one_current_billing, on: :create
  
  def check_time_in_and_out
    if self.time_out.present?
      errors.add(:time_out, "Waktu Keluar Muncul Setelah Waktu Masuk") if self.time_out.present? && self.time_out < self.time_in
    end
  end
  
  def only_one_current_billing
    errors.add(:base, 'Tidak Dapat Membuat Billing Baru Jika Ada Yang Billing Sebelumnya Yang Belum Di Tutup') if Billing.current.size > 0
  end
  
  def stop!
    if self.time_out.nil?
      update_attributes(time_out: Time.now)
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
    self.expiration = Date.today + 1.day
  end
  
  def copy_to_reports
      reports.build(:date => :created_at, :member_id => :member_id, :time_in => :time_in, :time_out => :time_out, :comment => :comment, :price => :price)
    end
  end
  
end
