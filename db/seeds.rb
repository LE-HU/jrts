10.times do |n|
  User.create!(email: "example#{n + 1}@example.com",
               password: "example#{n + 1}@example.com")
end

20.times do
  Event.create!(name: Faker::Game.title,
                description: Faker::TvShows::BojackHorseman.tongue_twister,
                event_time: Time.now + rand(1..1_000_000),
                guest_limit: rand(50..150),
                ticket_price: rand(1000..10_000))
end

30.times do
  Ticket.create!(user_id: rand(1..10),
                 event_id: rand(1..20),
                 paid: [true, false].sample)
end

puts 'Seed successful.'
