require 'test_helper'

class JobCategoriesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get job_category_url(1)
    assert_response :success
  end
end
