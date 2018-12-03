# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    street "MyString"
    city "MyString"
    state "MyString"
    country "MyString"
    pin_code "MyString"
    company_id 1
    is_headquarter false
  end
end
