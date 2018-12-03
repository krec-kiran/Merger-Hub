# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_company, :class => 'Admin::Company' do
    name "MyString"
    employees_count 1
    established_date "2015-08-19"
    summary "MyText"
    website "MyString"
  end
end
