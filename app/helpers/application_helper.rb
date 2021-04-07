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

  def all_clients
    User.where(role: 'client').pluck(:name, :id)
  end

  def all_freelancers
    User.where(role: 'freelancer').pluck(:name, :id)
  end

  def all_projects
    Project.all.pluck(:title, :id)
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

  def project_awarded?(project)
    Project.where(id: project.id).joins(:bids).where(bids: { status: 'awarded' }).empty? ? false : true
  end

  def total_projects_posted(user)
    user.projects.count
  end

  def count_total_proposals(user)
    Project.where(client: user).joins(:bids).count
  end

  def total_projects_awarded(user)
    Project.where(client: user).joins(:bids).where(bids: { status: 'awarded' }).count
  end

  def total_proposals_accepted(user)
    Project.where(client: user).joins(:bids).where(bids: { status: 'accepted' }).count
  end

  def total_proposals_rejected(user)
    Project.where(client: user).joins(:bids).where(bids: { status: 'rejected' }).count
  end

  def total_projects_done(user)
    Bid.where('(status =? and freelancer_id =?)', 'awarded', user.id).count
  end

  def any_bids?(user)
    Bid.where(freelancer: user).try(:count) > 0
  end

  def total_bids_by_user?(user)
    user.bids.count
  end

  def average_bid_value(user)
    Bid.where(freelancer_id: user.id).average(:value).to_i
  end

  def maximum_bid_by_user(user)
    Bid.where(freelancer_id: user.id).maximum('value') || 0
  end

  def minimum_bid_by_user(user)
    Bid.where(freelancer_id: user.id).minimum('value') || 0
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

  def max_bid(project)
    project.bids.maximum('value')
  end

  def avg_bid(project)
    project.bids.average('value').to_i
  end

  def total_unread_messages
    unread_messages = Conversation.where('sender_id = ? OR recipient_id= ? ', current_user.id, current_user.id).joins(:messages).where('messages.read = ? AND user_id !=?  ', false, current_user.id).count
    if unread_messages > 9
      '9+'
    else
      unread_messages
    end
  end

  def total_unread_notifications
    total_unread_notifications = Notification.where(user: current_user, read: false).count
    if total_unread_notifications > 9
      '9+'
    else
      total_unread_notifications
    end
  end

  def bidding_profile_exist?
    !BiddingProfile.where(freelancer: current_user).empty?
  end
end
