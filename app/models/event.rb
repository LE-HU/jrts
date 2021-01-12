class Event < ApplicationRecord
  has_many :tickets, dependent: :destroy
  has_many :paid_tickets, -> { paid }, class_name: 'Ticket'
  has_many :users, through: :appointments

  def available_tickets
    guest_limit - paid_tickets.size
  end
end
