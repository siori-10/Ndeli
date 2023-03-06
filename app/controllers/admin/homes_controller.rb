class Admin::HomesController < ApplicationController
  def top
    if params[:q]
      @word = params[:q][:dish_name_cont]
    end
    @recipes = Recipe.all.page(params[:page])
    @search = Recipe.ransack(params[:q])
    @search_recipes = @search.result
  end
  
end
