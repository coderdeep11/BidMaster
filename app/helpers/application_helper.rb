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
    [['Accounting & Consulting', 'Accounting & Consulting'], ['Admin Support', 'Admin Support'], ['Customer Service', 'Customer Service'],
     ['Data Science & Analytics', 'Data Science & Analytics'],
     ['Design & Creative', 'Design & Creative'],

     ['IT & Networking', 'IT & Networking'],
     %w[Legal Legal],
     ['Sales & Marketing', 'Sales & Marketing'],

     ['Web, Mobile & Software Dev', 'Web, Mobile & Software Dev'],
     %w[Writing Writing]]
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

  def user_freelancer?(user)
    user.try(:role) == 'freelancer'
  end

  def total_bids_by_freelancer?(_bid)
    Bid.where(freelancer: current_user).count
  end
end
