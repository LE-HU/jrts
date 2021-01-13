# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.describe 'Users routes', type: :request do
  resource 'Users' do
    header 'Content-Type', 'application/json'

    post 'auth/users' do
      parameter :email, 'User email'
      parameter :password, 'User password'

      let(:raw_post) { params.to_json }

      it 'user sign up' do
        do_request(email: 'email@example.com', password: '12345678')
        expect(status).to eq 200
      end
    end

    post 'auth/users/sign_in' do
      before do
        @user = FactoryBot.create :user,
                                  email: 'email@example.com',
                                  password: '12345678'
      end

      parameter :email, 'User email'
      parameter :password, 'User password'

      let(:raw_post) { params.to_json }

      it 'user log in' do
        do_request(email: 'email@example.com', password: '12345678')
        expect(status).to eq 200
      end
    end
  end
end
