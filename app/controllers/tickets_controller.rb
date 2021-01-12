class TicketsController < ApplicationController
  # Devise authentication is to be turned on once the front-end is ready.
  # before_action :authenticate_user!

  def index
    @tickets = event.tickets

    render json: @tickets
  end

  def show
    render json: ticket
  end

  def create
    # Stub current user before authentication is set up.
    current_user = User.all.sample

    ticket = event.tickets.build(event_id: params[:event_id])
    ticket[:user_id] = current_user.id

    # Stub payment service response
    payment_response = %i[card_error payment_error success].sample

    if ticket.save && charge_payment(payment_response)
      ticket.paid = true
      render json: ticket, status: :created, location: event_tickets_url
    else
      render json: ticket.errors, status: :unprocessable_entity
    end
  end

  def destroy
    ticket.destroy
    render json: ticket
  end

  private

  def event
    @event ||= Event.find(params[:event_id])
  end

  def ticket
    @ticket ||= event.tickets.find(params[:id])
  end

  def charge_payment(response_status)
    Payment::Gateway.charge(amount: event.ticket_price,
                            token: response_status)
  end
end
