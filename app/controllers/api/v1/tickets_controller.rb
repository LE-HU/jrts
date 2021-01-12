module Api
  module V1
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

        ticket = event.tickets.build
        ticket[:user_id] = current_user.id

        # Stub payment service response
        payment_response = %i[card_error payment_error success].sample

        begin
          charge_payment(payment_response)
        rescue Payment::Gateway::CardError
          render json: {
            "error": 'card error'
          }, status: :unprocessable_entity
        rescue Payment::Gateway::PaymentError
          render json: {
            "error": 'payment error'
          }, status: :unprocessable_entity
        else
          ticket.paid = true
          if ticket.save
            render json: ticket, status: :created,
                   location: api_v1_event_tickets_url
          else
            render json: ticket.errors, status: :unprocessable_entity
          end
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
  end
end
