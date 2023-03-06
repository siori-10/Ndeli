class Public::CustomersController < ApplicationController

  def show
     @customer= current_customer
     @recipes = @customer.recipes

    favorites = Favorite.where(customer_id: current_customer.id).pluck(:recipe_id)  # ログイン中の会員のお気に入りのrecipe_idカラムを取得
    @favorite_list = Recipe.find(favorites)     # recipesテーブルから、お気に入り登録済みのレコードを取得
  end

  def edit
    @customer= current_customer
  end

  def update
    @customer= current_customer
    @customer.profile_image.attach(params[:customer][:get_image_profile])
    @customer.update(customer_params)
    redirect_to customers_my_page_path
  end

  def unsubscribe

  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted:true)
    reset_session
    recipes = Recipe.where(customer_id: @customer.id)
    recipes.destroy_all
    flash[:notice] = "退会しました"
    redirect_to root_path
  end


  private
  def customer_params
    params.require(:customer).permit(:nickname, :email, :profile_image, :self_introduction)
  end
end
