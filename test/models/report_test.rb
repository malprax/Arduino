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

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
