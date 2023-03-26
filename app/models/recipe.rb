class Recipe < ApplicationRecord

# 料理画像、手順画像
has_one_attached :dish_image
# has_many_attached :procedure_image

def get_image(width, height)# 料理画像
    unless dish_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      dish_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    dish_image.variant(resize_to_limit: [width, height]).processed
end

def get_image2(width, height)# 手順画像
    unless procedure_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      procedure_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    procedure_image.variant(resize_to_limit: [width, height]).processed
end
def self.ransackable_attributes(auth_object = nil)
    ["categoriy_id", "created_at", "customer_id", "dish_name", "id", "is_draft", "numder_people", "procedure", "recipe_description", "tag_id", "updated_at"]
end


with_options presence: true, on: :publicize do
    
    validates :dish_image
    validates :dish_name
    validates :recipe_description
    validates :material_name
    validates :quantity
    validates :description
  end
  validates :dish_name, length: { maximum: 14 }, on: :publicize
  validates :recipe_description, length: { maximum: 80 }, on: :publicize
  
  
  # has_many :customers, dependent: :destroy

   has_many :favorites, dependent: :destroy
   belongs_to :customer, optional: :true　#レシピ/お気に入り１：多
   belongs_to :categoriy
   has_many :materials, dependent: :destroy
   has_many :recipe_descriptions
#   has_many :tag_recipes, dependent: :destroy
#   has_many :tags, through: :tag_recipes, dependent: :destroy

   has_many :comments, dependent: :destroy

   accepts_nested_attributes_for :materials, reject_if: :all_blank, allow_destroy: true
   accepts_nested_attributes_for :recipe_descriptions, reject_if: :all_blank, allow_destroy: true
   
   
end
