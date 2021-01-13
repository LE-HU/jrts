require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :routing do
  describe 'routing' do
    let(:event) { FactoryBot.create :event }

    it 'routes to #index' do
      expect(get: 'api/v1/events').to route_to('api/v1/events#index')
    end

    it 'routes to #show' do
      expect(get: "api/v1/events/#{event.id}")
        .to route_to('api/v1/events#show', id: event.id.to_s)
    end

    it 'routes to #create' do
      expect(post: 'api/v1/events').to route_to('api/v1/events#create')
    end

    it 'routes to #update via PUT' do
      expect(put: "api/v1/events/#{event.id}")
        .to route_to('api/v1/events#update', id: event.id.to_s)
    end

    it 'routes to #update via PATCH' do
      expect(patch: "api/v1/events/#{event.id}")
        .to route_to('api/v1/events#update', id: event.id.to_s)
    end

    it 'routes to #destroy' do
      expect(delete: "api/v1/events/#{event.id}")
        .to route_to('api/v1/events#destroy', id: event.id.to_s)
    end
  end
end
