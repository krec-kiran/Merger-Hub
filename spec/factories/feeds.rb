# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feed do
    title ""
    url "MyText"
    image_url "MyText"
    entry_url "MyText"
    author "MyString"
    category "MyText"
    summary "MyText"
    published "2015-08-06 13:01:03"
  end
end
