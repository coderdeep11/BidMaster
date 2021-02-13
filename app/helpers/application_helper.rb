module ApplicationHelper
  def user_image(user_id)
    user = User.find(user_id)
    if user.profile_image.attached?
      user.avatar
    else
      'default_avatar.png'
    end
  end
end
