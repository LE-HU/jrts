class Event < ApplicationRecord
  has_many :tickets, dependent: :destroy
  has_many :paid_tickets, -> { paid }, class_name: 'Ticket'
  has_many :users, through: :tickets

  validates :name, presence: true, length: { maximum: 80 }
  validates :description, length: { maximum: 3000 }
  validates :guest_limit, presence: true, numericality: { only_integer: true,
                                                          greater_than: 0 }
  validates :ticket_price, presence: true, numericality: { only_integer: true }
  validate :event_happens_in_the_future

  def detailed_info
    users_with_ticket = users.each_with_object([]) do |user, arr|
      arr << { user: user.email }
    end

    { name: name,
      description: description,
      date: event_time,
      ticket_price: ticket_price,
      participants: users_with_ticket }.to_json
  end

  private

  def available_tickets
    guest_limit - paid_tickets.size
  end

  def event_happens_in_the_future
    if event_time.present? && event_time < Time.now
      errors.add(:event_time,
                 "can't happen in the past")
    end
  end
end
