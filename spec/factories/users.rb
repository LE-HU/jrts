FactoryBot.define do
  factory :user do
    email { "example#{rand(1..1000)}@example.com" }
    password { '12345678' }
  end
end
