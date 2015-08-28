# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  date       :datetime
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
  belongs_to :billing
  
end
