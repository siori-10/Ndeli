class Public::FavoritesController < ApplicationController
  
  
  before_action :set_post
  before_action :authenticate_customer! # ログイン中のユーザーのみに許可（未ログインなら、ログイン画面へ移動）

def create
  if @recipe.customer_id != current_customer.id #投稿者本人以外に限定
    @favorite = Favorite.create(customer_id: current_customer.id, recipe_id: @recipe.id)
  end
end 

def destroy #お気に入り削除
    @favorite = Favorite.find_by(customer_id: current_customer.id, recipe_id: @recipe.id)
    @favorite.destroy
end
  
  
  def index
  end
end

 private
  def set_post
    @recipe = Recipe.find(params[:recipe_id])
  end