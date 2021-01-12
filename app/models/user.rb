class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tickets, dependent: :destroy
  has_many :paid_tickets, -> { paid }, class_name: 'Ticket'
  has_many :events, through: :tickets

  def buy_ticket; end

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
