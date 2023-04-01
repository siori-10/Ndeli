class Material < ApplicationRecord

  with_options presence: true do

    validates :material_name
    validates :quantity
    #validates :description
  end
end
