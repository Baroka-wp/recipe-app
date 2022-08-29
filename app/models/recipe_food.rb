class RecipeFood < ApplicationRecord
  belongs_to :recipe, counter_cache: true
  belongs_to :food

  validates :quantity, presence: true
end
