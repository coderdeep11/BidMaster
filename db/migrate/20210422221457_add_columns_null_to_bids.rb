class AddColumnsNullToBids < ActiveRecord::Migration[6.0]
  def change
    change_column_null :bids, :value, false
    change_column_null :bids, :proposal, false
    change_column_null :bids, :project_id, false
  end
end
