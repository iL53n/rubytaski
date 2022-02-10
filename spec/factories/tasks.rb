FactoryBot.define do
  sequence :title do |n|
    "TestTask_#{n}"
  end

  factory :task do
    title
    description { 'text text text text text' }
    user

    trait :invalid do
      title { nil }
    end
  end
end
