require 'rails_helper'

RSpec.describe 'Admins', type: :request do
  describe 'Admin login page' do
    it 'redirects to login page' do
      get '/admin'
      expect(response).to redirect_to('/admin/login')
    end

    it 'opens login page' do
      get '/admin/login'
      expect(response).to have_http_status(:ok)
    end
  end
end
