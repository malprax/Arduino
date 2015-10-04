class Park < ActiveRecord::Base
  belongs_to :billing
  before_save :set_number
 
  
  def set_number
    if    billing.number_park == 1 #jika keluar nomor parkirnya 1 maka harus parkir di nomor 1
      self.number = 1  
    elsif billing.number_park == 2
      self.number = 2
    elsif billing.number_park == 3
      self.number = 3   
    elsif billing.number_park == 4
      self.number = 4
    elsif billing.number_park == 5
      self.number = 5     
    elsif billing.number_park == 6
      self.number = 6   
    elsif billing.number_park == 7
      self.number = 7
    elsif billing.number_park == 8
      self.number = 8      
    elsif billing.number_park == 9
      self.number = 9    
    else
      errors.add(:number, 'Tidak Ada Tempat parkir Atau Anda Salah Parkir')
    end
  end
end
