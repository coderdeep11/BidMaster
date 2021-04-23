module BiddingProfilesHelper
  def  authorize_bidding_profile(resource)
    current_user == resource&.freelancer
  end
end
