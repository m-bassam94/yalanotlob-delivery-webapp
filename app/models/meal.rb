class Meal < ApplicationRecord
    validates :meal, presence: true
    validates :amount, presence: true
    validates :price, presence: true
end
