class Event < ApplicationRecord
  has_many :tickets, dependent: :nullify
  has_many :users, through: :appointments

  def available_tickets
    guest_limit - tickets_count
  end
end
