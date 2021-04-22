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
    categories = ['Accounting & Consulting', 'Admin Support', 'Customer Service', 'Data Science & Analytics',
                  'Design & Creative', 'IT & Networking',
                  'Legal', 'Sales & Marketing', 'Web, Mobile & Software Dev', 'Writing']
    categories.each_with_index.map { |i, _j| [i, i] }
  end

  ## for searching projects and freelancers
  def search_type(type)
    session[:search_type] = type
  end

  def search_type?
    session[:search_type]
  end

  def current_path(url)
    request.path == url
  end

  # project awarded by client or not
  def project_awarded?(project)
    Project.awarded?(project).empty? ? false : true
  end

  # total projects by client
  def total_projects_posted(user)
    Project.total_projects_posted_by_client(user)
  end

  # total proposals on a project
  def count_total_proposals(user)
    Project.total_proposals_on_project(user)
  end

  # total projects awarded by client
  def total_projects_awarded(user)
    Project.total_projects_awarded_by_client(user)
  end

  def total_proposals_accepted(user)
    Project.proposals_accepted(user)
  end

  def total_proposals_rejected(user)
    Project.proposals_rejected(user)
  end

  # projects completed by freelancer
  def total_projects_done(user)
    Bid.awarded_bids(user)
  end

  def any_bids?(user)
    Bid.exist(user) > 0
  end

  # total bids by a freelancer
  def total_bids_by_user?(user)
    User.total_bids_count(user)
  end

  # average bid value of a freelancer
  def average_bid_value(user)
    Bid.average_bid(user)
  end

  # freelancer's max bid
  def maximum_bid_by_user(user)
    Bid.max_bid_value(user)
  end

  # freelancer's min bid
  def minimum_bid_by_user(user)
    Bid.min_bid_value(user)
  end

  def user_freelancer?(user)
    user.try(:role) == 'freelancer'
  end

  def total_bids_by_freelancer?(_bid)
    Bid.where(freelancer: current_user).count
  end

  def user_client?(user)
    user.try(:role) == 'client'
  end

  def authorized_only_to_clients
    flash[:alert] = 'only clients are authorized to use this page'
    redirect_to root_path
  end

  def authorized_only_to_freelancers
    flash[:alert] = 'only freelancers are authorized to use this page'
    redirect_to root_path
  end

  def limit_characters(string)
    string.length > 70 ? "#{string.from(0).to(70)}...." : string
  end

  # maximum bid on a project
  def max_bid(project)
    Bid.max_bid_on_project(project)
  end

  # average bid value on a project
  def avg_bid(project)
    Bid.avg_bid_on_project(project)
  end

  # unread notifications count
  def total_unread_messages
    unread_messages = Conversation.total_unread_messages_count(current_user)
    if unread_messages > 9
      '9+'
    else
      unread_messages
    end
  end

  # Unread messages count
  def total_unread_notifications
    total_unread_notifications = Notification.total_unread_notifications_count(current_user)
    if total_unread_notifications > 9
      '9+'
    else
      total_unread_notifications
    end
  end

  def bidding_profile_exist?
    !BiddingProfile.exist?(current_user).empty?
  end
end
