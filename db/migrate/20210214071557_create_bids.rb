class CreateBids < ActiveRecord::Migration[6.0]
  def change
    create_table :bids do |t|
      t.integer :value
      t.text :proposal
      t.references :freelancer, null: false, foreign_key: { to_table: :users }
      t.references :project , foreign_key: true
      t.timestamps
    end
  end
end
