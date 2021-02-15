require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
  end
  test 'should get index' do
    message = messages(:one)
    get conversation_messages_url(message)
    assert_response :success
  end
end
