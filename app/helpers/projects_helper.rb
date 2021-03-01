module ProjectsHelper
  def authorize_project(project)
    current_user == project.client
  end

  def project_awarded?
    if !Bid.where(aasm_state: 'awarded').nil?
      true

    else
      false
    end
  end

  def max_bid(project)
    project.bids.maximum('value')
  end

  def avg_bid(project)
    project.bids.average('value')
  end
end
