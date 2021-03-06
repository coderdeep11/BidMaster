class FreelancerRouteConstraint
  def matches?(request)
    user = current_user(request)
    user.present? && user.role == 'freelancer' && !BiddingProfile.where(freelancer: user).empty?
  end

  def current_user(request)
    User.find_by_id(request.session[:user_id])
  end
end
