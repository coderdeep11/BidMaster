module ProfilesHelper
  def authenticate_profile(user)
    user == current_user
  end

  def authorize_client(user)
    user == current_user || !Project.authorize_client_profile(user, current_user).empty? || current_user.admin?
  end
end
