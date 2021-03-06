class Project < ApplicationRecord
  belongs_to :client, class_name: 'User', inverse_of: :projects
  has_many :bids, dependent: :destroy
  has_rich_text :description
  validate :is_user_client?
  validates :title, presence: { message: 'can\'t be empty' }, length: { in: 30..100, message: 'Title should be within 30 to 100 characters' }
  validate :title_words_within_limit?
  validates :category, presence: { message: 'Choose a Category' }
  has_one :action_text_rich_text,
          class_name: 'ActionText::RichText',
          as: :record
  def title_words_within_limit?
    unless title.nil?
      errors.add(:title, 'title should contain atleast 10 words') unless title.split(' ').length > 10
    end
  end

  def is_user_client?
    errors.add(:base, 'Only Clients are allowed to post project') unless client.role == 'client'
  end
end
