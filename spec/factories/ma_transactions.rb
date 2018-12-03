# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ma_transaction do
    date "2015-08-14 17:51:14"
    target_id 1
    sector_id 1
    value 1.5
    transaction_type_id 1
    investor_id 1
    seller_id 1
  end
end
