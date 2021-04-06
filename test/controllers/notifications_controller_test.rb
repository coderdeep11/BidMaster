require 'test_helper'

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    get '/login'
    sign_in users(:user_001)
    post user_sessions_url
  end
  test 'should get index' do
    get notifications_url, xhr: true
    assert_response :success
  end
end
