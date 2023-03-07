class Tag < ApplicationRecord
  has_many :tag_recipes, dependent: :destroy
  has_many :recipes, through: :tag_recipes

end
