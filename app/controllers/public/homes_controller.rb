class Public::HomesController < ApplicationController
  def top
    @recipes = Recipe.where(is_draft: false).order(created_at: :desc).page(params[:page]).per(3)
  end

  def about
  end
end
