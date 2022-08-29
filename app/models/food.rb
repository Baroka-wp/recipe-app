class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :recipes, through: :recipe_foods
  validates :name, :price, :measurement_unit, presence: true
  accepts_nested_attributes_for :recipe_foods
end
