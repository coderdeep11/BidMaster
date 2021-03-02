module ProfilesHelper
  def authenticate_profile(user)
    user == current_user
  end

  def authorize_client(user)
    user == current_user
  end
end
