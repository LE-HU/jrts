module Api
  module V1
    class EventsController < ApplicationController
      # Devise authentication is to be turned on once the front-end is ready.
      # before_action :authenticate_user!

      def index
        @events = Event.all

        render json: @events
      end

      def show
        render json: event.detailed_info
      end

      def create
        event = Event.new(event_params)

        if event.save
          render json: event, status: :created, location: api_v1_events_url
        else
          render json: event.errors, status: :unprocessable_entity
        end
      end

      def update
        if event.update(event_params)
          render json: event
        else
          render json: event.errors, status: :unprocessable_entity
        end
      end

      def destroy
        event.destroy
        render json: event
      end

      private

      def event
        @event ||= Event.find(params[:id])
      end

      def event_params
        params.require(:event).permit(:name, :description, :event_time, :guest_limit, :ticket_price)
      end
    end
  end
end
