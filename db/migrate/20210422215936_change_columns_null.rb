class ChangeColumnsNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :projects, :title, false
    change_column_null :projects, :category, false
  end
end
