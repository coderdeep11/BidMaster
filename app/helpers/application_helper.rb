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
    categories.each_with_index.map { |i, j| [i, i] }
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

  def total_projects_posted(user)
    user.projects.count
  end

  def count_total_proposals(user)
    Project.where(client: user).joins(:bids).count
  end

  def total_projects_awarded(user)
    Project.where(client: user).joins(:bids).where(bids: { aasm_state: 'awarded' }).count
  end

  def total_proposals_accepted(user)
    Project.where(client: user).joins(:bids).where(bids: { aasm_state: 'accepted' }).count
  end

  def total_proposals_rejected(user)
    Project.where(client: user).joins(:bids).where(bids: { aasm_state: 'rejected' }).count
  end

  def total_projects_done(user)
    Bid.where('(aasm_state =? and freelancer_id =?)', 'awarded', user.id).count
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
    project.bids.average('value')
  end
end
