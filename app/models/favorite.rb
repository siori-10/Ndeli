class Favorite < ApplicationRecord
  belongs_to :customer　# 会員/お気に入り　1：多
  belongs_to :recipe #レシピ/お気に入り　１：多
  
  validates_uniqueness_of :recipe_id, scope: :customer_id
  # 同じ投稿を複数回お気に入りに登録させない
  
end
