class Public::HomesController < ApplicationController
  def top
    @recipes = Recipe.all.page(params[:page]).per(3)
  end

  def about
  end
end
