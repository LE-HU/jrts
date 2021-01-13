require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.describe 'Tickets routes', type: :request do
  resource 'Tickets' do
    header 'Content-Type', 'application/json'

    get '/api/v1/events/1/tickets' do
      before do
        @event = FactoryBot.create :event, id: 1
        3.times do |user_id|
          FactoryBot.create :user, id: user_id
          FactoryBot.create :ticket, event_id: @event.id,
                                     user_id: user_id
        end
      end

      example_request 'list all tickets of an event' do
        expect(status).to eq 200
      end
    end

    get '/api/v1/events/1/tickets/1' do
      before do
        @user = FactoryBot.create :user
        @event = FactoryBot.create :event, id: 1
        @ticket = FactoryBot.create :ticket, id: 1,
                                             event_id: @event.id,
                                             user_id: @user.id
      end

      example_request 'show ticket' do
        expect(status).to eq 200
      end
    end

    post '/api/v1/events/1/tickets' do
      # TODO: current_user & payment_response params is a temporary workaround
      before do
        @user = FactoryBot.create :user, id: 1
        @event = FactoryBot.create :event, id: 1
      end

      let(:raw_post) { params.to_json }

      it 'create ticket' do
        do_request(ticket: { user_id: @user.id,
                             event_id: @event.id },
                   current_user: @user,
                   payment_response: :success)
        expect(status).to eq 201
      end
    end

    delete '/api/v1/events/1/tickets/1' do
      before do
        @user = FactoryBot.create :user
        @event = FactoryBot.create :event, id: 1
        @ticket = FactoryBot.create :ticket, id: 1,
                                             event_id: @event.id,
                                             user_id: @user.id
      end

      example_request 'delete ticket' do
        expect(status).to eq 200
      end
    end
  end
end
