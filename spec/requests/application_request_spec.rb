require 'rails_helper'

RSpec.describe 'Applications', type: :request do
  describe 'GET #index' do
    it 'renders the index page' do
      get '/'
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #retail' do
    it 'renders the retail page' do
      get '/retail'
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #fmcg' do
    it 'renders the fmcg page' do
      get '/fmcg'
      expect(response).to have_http_status(:ok)
    end
  end
end
