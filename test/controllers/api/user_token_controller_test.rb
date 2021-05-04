require "test_helper"

class API::UserTokenControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = User.create!(phone_number: '+79991113344')
    user.password = '1234'
  end

  test 'creates user token' do
    post '/api/user_token',
         params: { phone_number: '+79991113344', password: '1234' }.to_json,
         headers: api_headers

    assert_response :created
  end

  test 'returns 404 because of wrong phone number' do
    post '/api/user_token',
         params: { phone_number: '+799911133', password: '1234' }.to_json,
         headers: api_headers

    assert_response :not_found
  end

  test 'returns 404 because of wrong password' do
    post '/api/user_token',
         params: { phone_number: '+799911133', password: '1266' }.to_json,
         headers: api_headers

    assert_response :not_found
  end

  test 'returns 404 because of wrong headers' do
    post '/api/user_token',
         params: { phone_number: '+799911133', password: '1234' }.to_json,
         headers: {}

    assert_response :not_found
  end
end
