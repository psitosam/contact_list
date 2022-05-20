FactoryBot.define do
  factory :contact do
    Faker::Config.locale = 'en-US'
    first_name { Faker::Name.first_name }
    middle_name { Faker::Name.middle_name }
    last_name { Faker::Name.last_name }
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip { Faker::Address.zip }
    number { Faker::PhoneNumber.cell_phone }
    phone_type { "home" } #need to find a way to get this to pick from 1 of 3 types.
    email { Faker::Internet.email }
  end
end
