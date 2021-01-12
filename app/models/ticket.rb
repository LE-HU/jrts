class Ticket < ApplicationRecord
  belongs_to :event
  belongs_to :user

  scope :paid, -> { where(paid: true) }
end
