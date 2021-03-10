require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
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
    get projects_url
    assert_response :success
  end

  test 'should get edit' do
    project = projects(:one)
    get edit_project_url(project)
    assert_response :success
  end
end
