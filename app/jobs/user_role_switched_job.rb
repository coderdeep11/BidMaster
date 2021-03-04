class UserRoleSwitchedJob < ApplicationJob
  queue_as :default

  def perform(user, old_role)
    if old_role == 'freelancer'
      user.bids.destroy_all unless user.bids.nil?
    else
      user.projects.destroy_all unless user.projects.nil?
    end
  end
end
