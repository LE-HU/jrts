class Ticket < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :paid, inclusion: { in: [true, false] }

  scope :paid, -> { where(paid: true) }
end
