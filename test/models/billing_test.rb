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

require 'test_helper'

class BillingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
