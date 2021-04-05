class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :email_confirmed, default: false
      t.string :password_digest
      t.string :role
      t.string :confirmation_token
      t.boolean :admin, default: false
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end
