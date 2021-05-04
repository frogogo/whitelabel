require "test_helper"

class APM::CallbackControllerTest < ActionDispatch::IntegrationTest
  test 'fails because of missing/wrong authorization header' do
    post '/apm/callback', params: {}, headers: {}
    assert_response :unauthorized
  end
end
