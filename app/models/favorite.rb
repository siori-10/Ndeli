class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :recipe

  validates_uniqueness_of :recipe_id, scope: :customer_id
  # 同じ投稿を複数回お気に入りに登録させない

end
