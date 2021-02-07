class CreateFreelancerInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :freelancer_infos do |t|
      t.string :category
      t.string :subcategory
      t.string :experience
      t.text :education
      t.integer :hourly_rate
      t.text :bio
      t.references :freelancer, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
