class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.boolean :email_confirmed, default: false
      t.string :password_digest, null: false
      t.string :role, null: false
      t.string :confirmation_token
      t.boolean :admin, default: false
      t.boolean :approved, default: false

      t.timestamps
      t.index :email, unique: true
      t.index :confirmation_token, unique: true
    end
  end
end
