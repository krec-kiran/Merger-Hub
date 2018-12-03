# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :candidate do
    name "MyString"
    email "MyString"
    city "MyString"
    language "MyString"
    year "MyString"
    company_id 1
    sector_id 1
    title_id 1
    vertical_id 1
    coverage_id 1
  end
end
