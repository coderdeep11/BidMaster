class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image
  validates :role, presence: true
  validates :name, presence: true
  validates :role, presence: true
  has_many :projects, foreign_key: 'client_id'
  has_many :notifications
end
