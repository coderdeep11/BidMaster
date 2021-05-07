class RemoveBioFromBiddingProfiles < ActiveRecord::Migration[6.0]
  def change
    remove_column :bidding_profiles, :bio, :text
  end
end
