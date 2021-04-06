class RemoveAasmStateFromBids < ActiveRecord::Migration[6.0]
  def change
    remove_column :bids, :aasm_state, :string
  end
end
