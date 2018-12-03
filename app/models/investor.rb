class Investor < ActiveRecord::Base
  belongs_to :ma_transaction
  belongs_to :buyer, class_name: "Company"
  belongs_to :seller, class_name: "Company"
end
