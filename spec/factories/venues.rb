# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue do
    name "MyString"
    address "MyString"
    address2 "MyString"
    city "MyString"
    state "MyString"
    zipcode "MyString"
    phone_number "MyString"
    user_id 1
  end
end
