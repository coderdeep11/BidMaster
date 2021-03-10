module BiddingProfilesHelper
  def  authorize_bidding_profile(resource)
    current_user == resource.try(:freelancer)
  end
end
