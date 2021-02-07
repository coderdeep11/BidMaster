class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :category
      t.string :subcategory
      t.text :description
      t.string :experience
      t.integer :min_budget
      t.integer :max_budget
      t.references :client, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
