class Public::FavoritesController < ApplicationController


  # before_action :set_post
  before_action :authenticate_customer! # ログイン中のユーザーのみに許可（未ログインなら、ログイン画面へ移動）

  def create
    @recipe = Recipe.find(params[:recipe_id])
    #投稿者本人以外に限定
    if @recipe.customer_id != current_customer.id
      @favorite = Favorite.new(customer_id: current_customer.id, recipe_id: @recipe.id)
      @favorite.save
      redirect_to favorites_path
    end
  end

    #お気に入り削除
  def destroy
    favorite = Favorite.find_by(customer_id: current_customer.id, recipe_id:params[:recipe_id])
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end

  def index
    favorites = Favorite.where(customer_id: current_customer.id).pluck(:recipe_id)
    @favorite_recipes = Recipe.where(id:favorites).page(params[:page])
  end
end