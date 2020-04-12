class Order < ApplicationRecord
  has_many :meals
  has_and_belongs_to_many :users
end
