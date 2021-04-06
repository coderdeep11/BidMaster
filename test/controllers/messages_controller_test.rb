require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    get '/login'
    sign_in users(:user_001)
    post user_sessions_url
  end
  attr_reader :current_user

  setup do
    @current_user = users(:user_001)
  end
  test 'should get index' do
    conversation = conversations(:one)
    get conversation_messages_url(conversation), xhr: true
    assert_response :success
  end
end
