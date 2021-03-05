class AddAdmin < ActiveRecord::Migration[6.0]
  def change
    User.create! do |u|
      u.name = 'Rakshit'
      u.email = 'test_admin@test.com'
      u.password = 'password'
      u.password_confirmation = 'password'
      u.admin = true
      u.approved = true
    end
  end
end
