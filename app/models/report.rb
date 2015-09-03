# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  date       :date
#  billing_id :integer
#  member_id  :integer
#  time_in    :datetime
#  time_out   :datetime
#  duration   :datetime
#  comment    :string
#  price      :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Report < ActiveRecord::Base
  has_many :billings
  has_many :members, through: :billings
  private
    def self.search(query)
        where("lower(comment) like ?", "%#{query}%") 
    end 
  
end
