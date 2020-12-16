require 'rails_helper'

RSpec.describe 'API::UserTokens', type: :request do
  before do
    user = User.create!(phone_number: '+79991113344')
    user.password = '1234'
  end

  describe 'Create user token' do
    it 'creates user token' do
      post '/api/user_token',
           params: { phone_number: '+79991113344', password: '1234' }.to_json,
           headers: api_headers

      expect(response).to have_http_status(:created)
    end

    it 'returns 404 because of wrong phone number' do
      post '/api/user_token',
           params: { phone_number: '+799911133', password: '1234' }.to_json,
           headers: api_headers

      expect(response).to have_http_status(:not_found)
    end

    it 'returns 404 because of wrong password' do
      post '/api/user_token',
           params: { phone_number: '+799911133', password: '1266' }.to_json,
           headers: api_headers

      expect(response).to have_http_status(:not_found)
    end

    it 'returns 404 because of wrong headers' do
      post '/api/user_token',
           params: { phone_number: '+799911133', password: '1234' }.to_json,
           headers: {}

      expect(response).to have_http_status(:not_found)
    end
  end
end
