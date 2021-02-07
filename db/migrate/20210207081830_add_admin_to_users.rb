class AddAdminToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :role, :string
    add_column :users, :admin, :boolean, default: false
  end
end
