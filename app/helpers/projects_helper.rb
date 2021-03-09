module ProjectsHelper
  def authorize_project(project)
    current_user == project.client
  end

  def project_awarded?(project)
    Project.where(project: project).joins(:bids).where(bids: { aasm_state: 'awarded' }) || false
  end
end
