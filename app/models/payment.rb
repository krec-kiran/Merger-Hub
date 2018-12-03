class Payment < ActiveRecord::Base
  belongs_to :user
  validates :email, :presence => true
  enum plan: {"trial" => 0, "premium_monthly" => 1, "cancelled" => 2 }
end
