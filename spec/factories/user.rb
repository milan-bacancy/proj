x = rand(0..1)
y= 'user'
if x == 1
  y = 'admin'
end

FactoryBot.define do
    factory :user do
      fname { Faker::Name.first_name }
      lname { Faker::Name.last_name }
      password { Faker::Internet.password(min_length: 6) }
      email { Faker::Internet.email }
      contact { Faker::PhoneNumber.phone_number }
      address { Faker::Address.city }
      gender { Faker::Gender.binary_type.downcase }   
      role { y }
    end
  end