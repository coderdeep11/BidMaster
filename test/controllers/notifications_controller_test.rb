require 'test_helper'

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
  end
  test 'should get index' do
    get notifications_url, xhr: true
    assert_response :success
  end
end
