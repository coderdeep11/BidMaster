module ProjectsHelper
  def authorize_project(project)
    current_user == project.client
  end
end
