class Member < ActiveRecord::Base
  validates :name, format: { with: /\A[a-zA-Z]+\z/,
      message: "only allows letters" }
end
