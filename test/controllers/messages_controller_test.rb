require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
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
