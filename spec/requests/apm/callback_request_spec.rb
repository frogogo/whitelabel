require 'rails_helper'

RSpec.describe 'APM::Callbacks', type: :request do
  describe 'Save receipt status' do
    it 'will fails because of missing/wrong authorization header' do
      post '/apm/callback', params: {}, headers: {}
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
