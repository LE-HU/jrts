FactoryBot.define do
  factory :ticket do
    event_id { rand(1..10) }
    user_id { rand(1..10) }
    paid { [true, false].sample }
  end
end
