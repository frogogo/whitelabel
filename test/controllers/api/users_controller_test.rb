require 'test_helper'

class API::UsersControllerTest < ActionDispatch::IntegrationTest
  test 'creates user' do
    post '/api/user',
         params: { phone_number: '+79991113344' }.to_json,
         headers: api_headers

    assert_response :created
  end

  test 'not creates user becase of wrong phone number' do
    post '/api/user',
         params: { phone_number: '799911133' }.to_json,
         headers: api_headers

    assert_response :unprocessable_entity
  end

  test 'not creates user becase of wrong headers' do
    post '/api/user',
         params: { phone_number: '+79991113344' }.to_json,
         headers: {}

    assert_response :unprocessable_entity
  end
end
