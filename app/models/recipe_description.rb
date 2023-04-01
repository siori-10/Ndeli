class RecipeDescription < ApplicationRecord
  has_one_attached :procedure_image

  with_options presence: true do

    validates :description
  end
end
