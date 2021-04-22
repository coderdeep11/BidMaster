class AddColumnNullToBiddingProfiles < ActiveRecord::Migration[6.0]
  def change
    change_column_null :bidding_profiles, :category, false
  end
end
