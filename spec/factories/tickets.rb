FactoryBot.define do
  factory :ticket do
    event { nil }
    user { nil }
    paid { false }
  end
end
