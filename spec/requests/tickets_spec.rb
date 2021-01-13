require 'rails_helper'

RSpec.describe '/tickets', type: :request do
  let(:user) { FactoryBot.create :user }
  let(:event) { FactoryBot.create :event }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # TicketsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  # TODO: populate once authentication is ready.
  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    before do
      @ticket1 = FactoryBot.create :ticket, user_id: user.id,
                                            event_id: event.id
      @ticket2 = FactoryBot.create :ticket, user_id: user.id,
                                            event_id: event.id
    end

    it 'renders a successful response' do
      get api_v1_event_tickets_url(event), headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it "returns all event's tickets" do
      get api_v1_event_tickets_url(event), headers: valid_headers, as: :json
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'GET /show' do
    let(:ticket) do
      FactoryBot.create :ticket, user_id: user.id,
                                 event_id: event.id
    end

    it 'renders a successful response' do
      get api_v1_event_ticket_url(event, ticket), as: :json
      expect(response).to be_successful
    end

    it 'returns selected ticket' do
      get api_v1_event_ticket_url(event, ticket), as: :json
      expect(JSON.parse(response.body)['id']).to eq(ticket.id)
    end
  end

  describe 'POST /create' do
    # TODO: current_user & payment_response params is a temporary workaround
    context 'with successful payment charge' do
      it 'creates a new Ticket' do
        expect do
          post api_v1_event_tickets_url(event),
               params: { current_user: user,
                         payment_response: :success },
               headers: valid_headers, as: :json
        end.to change(Ticket, :count).by(1)
      end

      it 'renders a JSON response with the new ticket' do
        post api_v1_event_tickets_url(event),
             params: { current_user: user,
                       payment_response: :success },
             headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with error returned by payment charge' do
      it 'card error does not create a new Ticket' do
        expect do
          post api_v1_event_tickets_url(event),
               params: { current_user: user,
                         payment_response: :card_error },
               headers: valid_headers, as: :json
        end.to change(Ticket, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'payment error does not create a new Ticket' do
        expect do
          post api_v1_event_tickets_url(event),
               params: { current_user: user,
                         payment_response: :payment_error },
               headers: valid_headers, as: :json
        end.to change(Ticket, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested ticket' do
      ticket = Ticket.create!(user_id: user.id, event_id: event.id)
      expect do
        delete api_v1_event_ticket_url(event, ticket),
               headers: valid_headers, as: :json
      end.to change(Ticket, :count).by(-1)
    end

    it 'returns deleted ticket' do
      ticket = Ticket.create!(user_id: user.id, event_id: event.id)
      delete api_v1_event_ticket_url(event, ticket), as: :json
      expect(JSON.parse(response.body)['id']).to eq(ticket.id)
      expect(response).to be_successful
    end
  end
end
