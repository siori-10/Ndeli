class Recipe < ApplicationRecord

# 料理画像、手順画像
has_one_attached :dish_image
has_one_attached :procedure_image


   has_many :customers, dependent: :destroy
   
   has_many :favorites, dependent: :destroy
   # belongs_to :customers, optional :true　#レシピ/お気に入り１：多
   # ↑お気に入り機能作ったときに入れた
   belongs_to :categoriy
   has_many :materials
   belongs_to :tag
   belongs_to :comment
   accepts_nested_attributes_for :materials, allow_destroy: true
end
