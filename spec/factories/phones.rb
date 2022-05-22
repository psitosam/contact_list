FactoryBot.define do
  factory :phone do
    association :contact
    Faker::Config.locale = 'en-US'
    number { Faker::PhoneNumber.cell_phone }
    phone_type {0}
  end
end
