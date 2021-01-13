require 'rails_helper'

RSpec.describe Api::V1::TicketsController, type: :routing do
  describe 'routing' do
    let(:user) { FactoryBot.create :user }
    let(:event) { FactoryBot.create :event }
    let(:ticket) do
      FactoryBot.create :ticket, user_id: user.id,
                                 event_id: event.id
    end

    it 'routes to #index' do
      expect(get: "api/v1/events/#{event.id}/tickets")
        .to route_to('api/v1/tickets#index', event_id: event.id.to_s)
    end

    it 'routes to #show' do
      expect(get: "api/v1/events/#{event.id}/tickets/#{ticket.id}")
        .to route_to('api/v1/tickets#show',
                     event_id: event.id.to_s, id: ticket.id.to_s)
    end

    it 'routes to #create' do
      expect(post: "api/v1/events/#{event.id}/tickets/")
        .to route_to('api/v1/tickets#create', event_id: event.id.to_s)
    end

    it 'routes to #destroy' do
      expect(delete: "api/v1/events/#{event.id}/tickets/#{ticket.id}")
        .to route_to('api/v1/tickets#destroy',
                     event_id: event.id.to_s, id: ticket.id.to_s)
    end
  end
end
