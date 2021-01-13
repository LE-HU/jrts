require 'rails_helper'

RSpec.describe '/events', type: :request do
  let(:valid_attributes) do
    { name: 'Event One',
      event_time: Time.now + 1000,
      guest_limit: 120,
      ticket_price: 8000 }
  end

  let(:invalid_attributes) do
    { name: '',
      event_time: Time.now - 1000,
      guest_limit: 0,
      ticket_price: -100 }
  end

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # EventsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  # TODO: populate once authentication is ready.
  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    before do
      @event1 = FactoryBot.create :event
      @event2 = FactoryBot.create :event
    end

    it 'renders a successful response' do
      get api_v1_events_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it 'returns all events' do
      get api_v1_events_url, as: :json
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'GET /show' do
    let(:event) { FactoryBot.create :event }

    it 'renders a successful response' do
      get api_v1_event_url(event), as: :json
      expect(response).to be_successful
    end

    it 'returns selected event' do
      get api_v1_event_url(event), as: :json
      expect(JSON.parse(response.body)['name']).to eq(event.name)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Event' do
        expect do
          post api_v1_events_url, params: { event: valid_attributes },
                                  headers: valid_headers, as: :json
        end.to change(Event, :count).by(1)
      end

      it 'renders a JSON response with the new event' do
        post api_v1_events_url, params: { event: valid_attributes },
                                headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type)
          .to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Event' do
        expect do
          post api_v1_events_url,
               params: { event: invalid_attributes }, as: :json
        end.to change(Event, :count).by(0)
      end

      it 'renders a JSON response with errors for the new event' do
        post api_v1_events_url,
             params: { event: invalid_attributes },
             headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PATCH /update' do
    let(:event) { FactoryBot.create(:event) }

    context 'with valid parameters' do
      let(:new_attributes) do
        { name: 'Updated Event',
          guest_limit: 60,
          ticket_price: 9999 }
      end

      it 'updates the requested event' do
        patch api_v1_event_url(event),
              params: { event: new_attributes },
              headers: valid_headers, as: :json
        event.reload

        expect(event.name).to eq('Updated Event')
        expect(event.guest_limit).to eq(60)
        expect(event.ticket_price).to eq(9999)
      end

      it 'renders a JSON response with the event' do
        patch api_v1_event_url(event),
              params: { event: new_attributes },
              headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['name']).to eq('Updated Event')
        expect(response.content_type)
          .to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the event' do
        patch api_v1_event_url(event),
              params: { event: invalid_attributes },
              headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested event' do
      event = Event.create! valid_attributes
      expect do
        delete api_v1_event_url(event), headers: valid_headers, as: :json
      end.to change(Event, :count).by(-1)
    end

    it 'returns deleted event' do
      event = Event.create! valid_attributes
      delete api_v1_event_url(event), headers: valid_headers, as: :json
      expect(JSON.parse(response.body)['name']).to eq(event.name)
      expect(response).to be_successful
    end
  end
end
