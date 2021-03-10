require 'test_helper'

class BiddingProfilesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    get '/users/sign_in'
    sign_in users(:user_002)
    post user_session_url
  end
  attr_reader :current_user

  setup do
    @current_user = users(:user_001)
  end
  test 'should get index' do
    get bidding_profiles_url

    assert_response :success
  end

  test 'should get edit' do
    bidding_profile = bidding_profiles(:one)
    get edit_bidding_profile_url(bidding_profile)

    assert_response :success
  end
end
