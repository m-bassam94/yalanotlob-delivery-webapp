class User < ApplicationRecord
  has_and_belongs_to_many :groups
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :friendships
  has_many :notifications, foreign_key: :recipient_id
  has_many :notifications, foreign_key: :actor_id

  has_one_attached :avatar
  has_and_belongs_to_many :orders
end
