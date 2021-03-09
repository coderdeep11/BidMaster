class RemoveHourlyRateFromFreelancerInfos < ActiveRecord::Migration[6.0]
  def change
    remove_column :freelancer_infos, :hourly_rate, :integer
  end
end
