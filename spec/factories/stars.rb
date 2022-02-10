FactoryBot.define do
  sequence :due_date do |n|
    Time.now + (86_400 * n)
  end

  factory :star do
    user
    task
    due_date

    trait :invalid do
      user { nil }
      task { nil }
    end
  end
end
