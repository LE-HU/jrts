require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.describe 'Events routes', type: :request do
  resource 'Events' do
    header 'Content-Type', 'application/json'

    get '/api/v1/events/' do
      before do
        @event1 = FactoryBot.create :event
        @event2 = FactoryBot.create :event
        @event3 = FactoryBot.create :event
      end

      example_request 'list all events' do
        expect(status).to eq(200)
      end
    end

    get '/api/v1/events/1' do
      before { @event = FactoryBot.create :event, id: 1 }

      example_request 'show event' do
        expect(status).to eq(200)
      end
    end

    post '/api/v1/events/' do
      with_options scope: :event, with_example: true do
        parameter :name, 'Event name'
        parameter :description, 'Event description'
        parameter :event_time, 'Event date/time'
        parameter :guest_limit, 'Event guest limit'
        parameter :ticket_price, 'Event ticket price'
      end

      let(:raw_post) { params.to_json }

      it 'create event' do
        do_request(event: { name: 'Event One', description: 'Lorem Ipsum',
                            event_time: Time.now + 1000, guest_limit: 80, ticket_price: 10_000 })
        expect(status).to eq 201
      end
    end

    patch '/api/v1/events/1' do
      before { @event = FactoryBot.create :event, id: 1 }

      with_options scope: :event, with_example: true do
        parameter :name, 'Event name', with_example: true
        parameter :description, 'Event description', with_example: true
        parameter :event_time, 'Event date/time', with_example: true
        parameter :guest_limit, 'Event guest limit', with_example: true
        parameter :ticket_price, 'Event ticket price', with_example: true
      end

      let(:raw_post) { params.to_json }

      it 'update event' do
        do_request(event: { name: 'Updated Event' })
        expect(status).to eq 200
      end
    end

    delete '/api/v1/events/1' do
      before { @event = FactoryBot.create :event, id: 1 }

      example_request 'delete event' do
        expect(status).to eq 200
      end
    end
  end
end
