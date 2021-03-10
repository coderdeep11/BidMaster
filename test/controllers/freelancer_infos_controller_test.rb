require 'test_helper'

class FreelancerInfosControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    get '/users/sign_in'
    sign_in users(:user_002)
    post user_session_url
  end
  test 'should get index' do
    get freelancer_infos_url

    assert_response :success
  end
end
