class CreateUsersV1 < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :role, null: false
      t.boolean :admin, default: false
      t.timestamps
    end
  end
end
