class Project < ApplicationRecord
  belongs_to :client, class_name: 'User', inverse_of: :projects
  has_many :bids, dependent: :destroy
  has_rich_text :description
  validate :is_user_client?
  validates :title, presence: { message: 'can\'t be empty' }, length: { in: 30..100, message: 'Title should be within 30 to 100 characters' }
  validate :title_words_within_limit?
  validates :category, presence: { message: 'Choose a Category' }
  validates :client_id, presence: { message: 'must select a Client' }

  has_one :action_text_rich_text,
          class_name: 'ActionText::RichText',
          as: :record

  # Scopes
  scope :my_projects, ->(current_user) { where(client: current_user) }
  scope :all_projects, -> { all.pluck(:title, :id) }
  scope :total_projects_posted_by_client, ->(current_user) { current_user.projects.count }
  scope :total_projects_awarded_by_client, ->(user) { where(client: user).joins(:bids).where(bids: { status: 'awarded' }).count }
  scope :total_proposals_on_project, ->(user) { where(client: user).joins(:bids).count }
  scope :awarded?, ->(project) { where(id: project.id).joins(:bids).where(bids: { status: 'awarded' }) }
  scope :proposals_accepted, ->(user) { where(client: user).joins(:bids).where(bids: { status: 'accepted' }).count }
  scope :proposals_rejected, ->(user) { where(client: user).joins(:bids).where(bids: { status: 'rejected' }).count }
  scope :authorize_client_profile, ->(user, current_user) { where(client: user).joins(:bids).find_by(bids: { freelancer: current_user }) }
  # Ex:- scope :active, -> {where(:active => true)}
  def title_words_within_limit?
    unless title.nil?
      errors.add(:title, 'title should contain atleast 10 words') unless title.split(' ').length > 10
    end
  end

  def is_user_client?
    errors.add(:base, 'Only Clients are allowed to post project') unless client.try(:role) == 'client'
  end
end
