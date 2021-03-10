class ChangeFreelancerInfosToBiddingProfiles < ActiveRecord::Migration[6.0]
  def change
    rename_table :freelancer_infos, :bidding_profiles
  end
end
