class Advisor < ActiveRecord::Base
  has_many :advisor_transactions
  belongs_to :company
  belongs_to :advisor, class_name: "Company"
end
