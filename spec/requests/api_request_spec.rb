require 'rails_helper'

RSpec.describe 'APIs', type: :request do
  describe 'Create user' do
    it 'creates user' do
      post '/api/user',
           params: { phone_number: '+79991113344' }.to_json,
           headers: api_headers

      expect(response).to have_http_status(:created)
    end

    it 'not creates user becase of wrong phone number' do
      post '/api/user',
           params: { phone_number: '799911133' }.to_json,
           headers: api_headers

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'not creates user becase of wrong headers' do
      post '/api/user',
           params: { phone_number: '+79991113344' }.to_json,
           headers: {}

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
