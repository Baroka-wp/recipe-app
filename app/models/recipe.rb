class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  
  has_many :foods, through: :recipe_foods
  validates :name, :description, :cooking_time, :prep_time, presence: true

  after_initialize :init
  def init
    self.recipe_foods_count ||= 0
  end
end
