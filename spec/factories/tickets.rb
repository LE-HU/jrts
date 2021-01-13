FactoryBot.define do
  factory :ticket do
    event_id { event.id }
    user_id { user.id }
    paid { true }
  end
end
