FactoryBot.define do
  factory :event do
    name { "MyString" }
    description { "MyText" }
    event_time { "2021-01-11 21:00:42" }
    guest_limit { 1 }
    tickets_count { 1 }
    ticket_price { 1 }
  end
end
