class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image
  validates :role, presence: true, unless: :user_admin?
  validates :name, presence: true
  has_many :notifications, dependent: :destroy
  has_one :freelancer_info, foreign_key: :freelancer_id, dependent: :destroy
  has_many :projects, foreign_key: :client_id, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :bids, foreign_key: :freelancer_id, dependent: :destroy
  has_many :conversations_as_sender, class_name: 'Conversation', foreign_key: :sender_id, dependent: :destroy
  has_many :conversations_as_recipient, class_name: 'Conversation', foreign_key: :recipient_id, dependent: :destroy

  before_update :role_changed

  def user_admin?
    admin?
  end

  def role_changed
    UserRoleSwitchedJob.perform_later(self, changed_attributes[:role]) unless changed_attributes[:role].nil?
  end

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    approved? ? super : :not_approved
  end
end
