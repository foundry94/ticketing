# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name "MyString"
    price "9.99"
    venue_id 1
  end
end
