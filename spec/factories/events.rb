FactoryBot.define do
  factory :event do
    name { Faker::Game.title }
    description { Faker::TvShows::BojackHorseman.tongue_twister }
    event_time { Time.now + rand(1..1_000_000) }
    guest_limit { rand(50..150) }
    ticket_price { rand(1000..10_000) }
  end
end
