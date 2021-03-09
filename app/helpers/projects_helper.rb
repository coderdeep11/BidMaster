module ProjectsHelper
  def authorize_project(project)
    current_user == project.try(:client)
  end
end
