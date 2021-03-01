class Project < ApplicationRecord
  belongs_to :client, class_name: 'User'
  has_many :bids, dependent: :destroy
  validate :is_user_client?
  attr_writer :current_step

  def is_user_client?
    errors.add('not possible') unless client.role == 'client'
  end

  def current_step
    @current_step || steps.first
  end

  def steps
    %w[title category description experience budget]
  end

  def prev_step
    self.current_step = steps[steps.index(current_step) - 1]
  end

  def next_step
    self.current_step = steps[steps.index(current_step) + 1]
  end

  def first_step
    current_step == 'title'
  end

  def last_step
    current_step == 'budget'
  end
end
