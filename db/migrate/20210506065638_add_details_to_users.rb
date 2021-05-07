class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :category, :string, null: false

    add_column :users, :subcategory, :string
  end
end
