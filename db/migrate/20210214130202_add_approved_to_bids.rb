class AddApprovedToBids < ActiveRecord::Migration[6.0]
  def change
    add_column :bids, :approved, :boolean
  end
end
