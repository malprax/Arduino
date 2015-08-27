# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  date       :datetime
#  member     :string
#  time_in    :string
#  time_out   :string
#  duration   :string
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
