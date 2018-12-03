# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phone do
    mobile "MyString"
    fax "MyString"
    landline "MyString"
    company_id 1
  end
end
