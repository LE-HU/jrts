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
    # Temporarily stub current user
    current_user = User.all.sample

    ticket = event.tickets.build(ticket_params)
    ticket[:user_id] = current_user.id

    if ticket.save
      render json: ticket, status: :created, location: event_tickets_url
    else
      render json: ticket.errors, status: :unprocessable_entity
    end
  end

  def update
    if ticket.update(ticket_params)
      render json: ticket
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

  def ticket_params
    params.require(:ticket).permit(:paid)
  end
end
