class Event < ApplicationRecord
  has_many :tickets
  has_many :users, through: :appointments

  def available_tickets
    guest_limit - tickets_count
  end
end
