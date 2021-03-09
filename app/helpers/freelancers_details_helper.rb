module FreelancersDetailsHelper
  def  authorize_freelancer_info(resource)
    current_user == resource.try(:freelancer)
  end
end
