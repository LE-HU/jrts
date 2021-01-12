class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tickets, dependent: :destroy
  has_many :paid_tickets, -> { paid }, class_name: 'Ticket'
  has_many :events, through: :tickets

  # Complement devise:validatable with additional validation.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  def owned_tickets
    user_tickets = []

    paid_tickets.each do |ticket|
      user_tickets << { event: ticket.event.name,
                        event_time: ticket.event.event_time }
    end

    { email: email,
      tickets: user_tickets }.to_json
  end
end
