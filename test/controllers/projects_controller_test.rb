require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
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
    get projects_url
    assert_response :success
  end

  test 'should get edit' do
    project = projects(:one)
    get edit_project_url(project)
    assert_response :success
  end
end
