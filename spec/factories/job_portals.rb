# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job_portal do
    title "MyString"
    summary "MyText"
    requirement "MyText"
    email "MyString"
    posted_date "2015-08-24"
    location_id 1
    user_id 1
    is_accept false
  end
end
