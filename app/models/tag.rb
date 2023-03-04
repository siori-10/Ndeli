class Tag < ApplicationRecord
  has_many :tag_recipes, dependent: :destroy

end
