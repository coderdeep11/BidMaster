module ApplicationHelper
  def user_image(user_id)
    user = User.find(user_id)
    if user.profile_image.attached?
      user.profile_image
    else
      'default_avatar.png'
    end
  end

  def all_categories
    [['Accounting & Consulting', 0], ['Admin Support', 1], ['Customer Service', 2],
     ['Data Science & Analytics', 3],
     ['Design & Creative', 4],

     ['IT & Networking', 5],
     ['Legal', 6],
     ['Sales & Marketing', 7],

     ['Web, Mobile & Software Dev', 8],
     ['Writing', 9]]
  end

  def search_type(type)
    session[:search_type] = type
  end

  def search_type?
    session[:search_type]
  end

  def current_path(url)
    request.path == url
  end

  def total_projects_done(user)
    Bid.where('(aasm_state =? and freelancer_id =?)', 'awarded', user.id).count
  end

  def average_bid_value(user)
    Bid.where(freelancer_id: user.id).average(:value).to_i
  end
end
