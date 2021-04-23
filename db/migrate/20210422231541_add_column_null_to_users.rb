class AddColumnNullToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :role, true
  end
end
