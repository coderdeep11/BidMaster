class RemoveColumnsFromProjects < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :description, :text
    remove_column :projects, :min_budget, :integer
    remove_column :projects, :max_budget, :integer
  end
end
