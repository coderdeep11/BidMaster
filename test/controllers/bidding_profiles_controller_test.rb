require 'test_helper'

class BiddingProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    get '/login'

    post sessions_url(:user_002)
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
