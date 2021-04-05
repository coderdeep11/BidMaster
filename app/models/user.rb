class User < ApplicationRecord
  has_secure_password
  has_one_attached :profile_image
  attr_accessor :current_password

  # Validations
  validates :role, presence: true, unless: :user_admin?
  validates :name, presence: true, length: { in: 5..20, message: 'must be within 5 to 20 characters' }
  validate :contain_last_name
  validates :email, presence: true, uniqueness: { message: 'already taken' }
  validates :password, presence: true, confirmation: { message: 'doesn\'t match password' }, unless: -> { password.blank? }

  # Relationships
  has_many :notifications, dependent: :destroy
  has_one :bidding_profile, foreign_key: :freelancer_id, dependent: :destroy
  has_many :projects, foreign_key: :client_id, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :bids, foreign_key: :freelancer_id, dependent: :destroy
  has_many :conversations_as_sender, class_name: 'Conversation', foreign_key: :sender_id, dependent: :destroy
  has_many :conversations_as_recipient, class_name: 'Conversation', foreign_key: :recipient_id, dependent: :destroy

  before_update :role_changed
  before_create :confirm_token
  def contain_last_name
    unless name.nil?
      errors.add(:name, 'need a last name') unless name.split(' ').length > 1
    end
  end

  def user_admin?
    admin?
  end

  def role_changed
    UserRoleSwitchedJob.perform_later(self, changed_attributes[:role]) unless changed_attributes[:role].nil?
  end

  def email_activate
    self.email_confirmed = true
    self.confirmation_token = nil
    save!(validate: false)
  end

  private

  def confirm_token
    self.confirmation_token = SecureRandom.urlsafe_base64.to_s if confirmation_token.blank?
  end
end
