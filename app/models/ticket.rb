class Ticket < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :paid, inclusion: { in: [true, false] }

  scope :paid, -> { where(paid: true) }

  def detailed_info
    { owner: user.email,
      event_name: event.name,
      event_time: event.event_time,
      ticket_price: event.ticket_price }.to_json
  end
end
