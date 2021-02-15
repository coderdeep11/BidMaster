require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
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
