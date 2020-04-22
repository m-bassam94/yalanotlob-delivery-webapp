class Order < ApplicationRecord
  validates :orderType, presence: true
  validates :resturant, presence: true

  belongs_to :user
  has_and_belongs_to_many :users
  has_one_attached :menu
end
