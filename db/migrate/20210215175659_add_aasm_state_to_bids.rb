class AddAasmStateToBids < ActiveRecord::Migration[6.0]
  def change
    add_column :bids, :aasm_state, :string
  end
end
