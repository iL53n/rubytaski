FactoryBot.define do
  sequence :email do |n|
    "user_#{n}@test.com"
  end

  sequence :nick_name do |n|
    "user_#{n}"
  end

  factory :user do
    email
    nick_name
    date_of_birth { '2012-01-09' }
    password { '12345678' }

    trait :invalid do
      email { nil }
    end
  end
end
