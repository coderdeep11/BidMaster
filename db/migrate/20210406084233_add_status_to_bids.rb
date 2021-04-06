class AddStatusToBids < ActiveRecord::Migration[6.0]
  def change
    add_column :bids, :status, :string, default: 'unapproved'
  end
end
