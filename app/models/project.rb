class Project < ApplicationRecord
  belongs_to :client, class_name: 'User', inverse_of: :projects
  has_many :bids, dependent: :destroy
  validate :is_user_client?
  validates :title, presence: { message: 'title can\'t be empty' }, length: { in: 30..100, message: 'Title should be within 30 to 100 characters' }
  validate :title_words_within_limit?
  validates :category, presence: { message: 'Choose a Category' }
  validates :description, presence: { message: 'description can\'t be empty' }, length: { in: 50..500, message: 'Title should be within 50 to 500 characters' }
  validate :description_words_within_limit?

  def title_words_within_limit?
    unless title.nil?
      errors.add(:title, 'title should contain atleast 10 words') unless title.split(' ').length > 10
    end
  end

  def description_words_within_limit?
    unless description.nil?
      errors.add(:description, 'description should contain atleast 20 words') unless description.split(' ').length > 10
    end
  end

  def is_user_client?
    errors.add(:base, 'Client Field can\'t have a freelancer') unless client.role == 'client'
  end
end
