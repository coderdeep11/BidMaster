require 'test_helper'

class JobCategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get job_categories_index_url
    assert_response :success
  end

end
