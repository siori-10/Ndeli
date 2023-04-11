class Public::HomesController < ApplicationController
  def top
    @recipes = Recipe.all.order(created_at: :desc).page(params[:page]).per(3)
  end

  def about
  end
end
