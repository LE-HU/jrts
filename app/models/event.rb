class Event < ApplicationRecord
  has_many :tickets, dependent: :destroy
  has_many :paid_tickets, -> { paid }, class_name: 'Ticket'
  has_many :users, through: :appointments

  validates :name, presence: true, length: { maximum: 80 }
  validates :description, length: { maximum: 3000 }
  validates :guest_limit, presence: true, numericality: { only_integer: true,
                                                          greater_than: 0 }
  validates :ticket_price, presence: true, numericality: { only_integer: true }
  validate :event_happens_in_the_future

  def available_tickets
    guest_limit - paid_tickets.size
  end

  private

  def event_happens_in_the_future
    if event_time.present? && event_time < Time.now
      errors.add(:event_time,
                 "can't happen in the past")
    end
  end
end
