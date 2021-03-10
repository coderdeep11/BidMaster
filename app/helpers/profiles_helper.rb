module ProfilesHelper
  def authenticate_profile(user)
    user == current_user
  end

  def authorize_client(user)
    user == current_user || !Project.where(client: user).joins(:bids).find_by(bids: { freelancer: current_user }).nil? || current_user.admin?
  end
end
