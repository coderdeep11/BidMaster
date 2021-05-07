class User < ApplicationRecord
  has_secure_password
  has_one_attached :profile_image
  attr_accessor :current_password, :education, :experience

  # Validations
  validates :role, presence: true, unless: :user_admin?
  validates :name, presence: true, length: { maximum: 30 }
  # #validate :contain_last_name
  validates :email, presence: true, uniqueness: { message: 'already taken' }
  validates :password, presence: true, confirmation: true, unless: -> { password.blank? }
  validates :category, presence: true

  # Relationships
  has_many :notifications, dependent: :destroy
  has_one :bidding_profile, foreign_key: :freelancer_id, dependent: :destroy
  has_many :projects, foreign_key: :client_id, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :bids, foreign_key: :freelancer_id, dependent: :destroy
  has_many :conversations_as_sender, class_name: 'Conversation', foreign_key: :sender_id, dependent: :destroy
  has_many :conversations_as_recipient, class_name: 'Conversation', foreign_key: :recipient_id, dependent: :destroy

  before_update :role_changed
  before_create :confirm_token, unless: :user_admin?
  before_create :remove_fields, if: :user_client?
  after_create :new_bidding_profile, if: :user_freelancer?
  before_update :update_bidding_profile, if: :user_freelancer?
  scope :not_current_user, ->(current_user) { where.not(id: current_user.id) }
  scope :all_clients, -> { where(role: 'client').pluck(:name, :id) }
  scope :all_freelancers, -> { where(role: 'freelancer').pluck(:name, :id) }
  scope :total_bids_count, ->(user) { user.bids.count }
  # Ex:- scope :active, -> {where(:active => true)}
  # def contain_last_name
  #  unless name.nil?
  #    errors.add(:name, 'need a last name') unless name.split(' ').length > 1
  #  end
  # end

  def user_admin?
    admin?
  end

  def user_client?
    role == 'client'
  end

  def user_freelancer?
    role == 'freelancer'
  end

  def remove_fields
    self.education = nil
    self.experience = nil
  end

  def role_changed
    new_bidding_profile if user_freelancer? && !changed_attributes[:role].nil?
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

  def new_bidding_profile
    BiddingProfile.create!(freelancer: self, education: education, experience: experience, category: category, subcategory: subcategory)
  end

  def update_bidding_profile
    unless changed_attributes[:category].nil?
      BiddingProfile.update(freelancer: self, category: category, subcategory: subcategory)
    end
  end
end
