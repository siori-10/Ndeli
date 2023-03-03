class Categoriy < ApplicationRecord
   has_many :recipes, dependent: :destroy
  
end
