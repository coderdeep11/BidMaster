require 'test_helper'

class FreelancerInfosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get freelancer_infos_index_url
    assert_response :success
  end

end