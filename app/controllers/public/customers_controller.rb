class Public::CustomersController < ApplicationController
 
  def show
     @customer= current_customer
     @recipes = @customer.recipes

    favorites = Favorite.where(customer_id: current_customer.id).pluck(:recipe_id)  # ログイン中の会員のお気に入りのrecipe_idカラムを取得
    @favorite_list = Recipe.find(favorites)     # recipesテーブルから、お気に入り登録済みのレコードを取得
  end

  def edit
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
  end
  
   
  private
  def customer_params
    params.require(:customer).permit(:nickname, :email, :profile_image, :self_introduction)
  end
end
