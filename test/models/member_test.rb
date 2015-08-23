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

require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
