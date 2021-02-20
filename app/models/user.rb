class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image
  validates :role, presence: true
  validates :name, presence: true
  has_many :notifications
  has_one :freelancer_info, foreign_key: :freelancer_id
  has_many :projects, foreign_key: :client_id
  has_many :messages
end
