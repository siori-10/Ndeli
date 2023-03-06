class Admin::RecipesController < ApplicationController
  def index
    
  end

  def show
    @recipe = Recipe.find(params[:id])
    @customer = Customer.find(params[:id])
  end

  def edit
  end
  
  def destroy
    recipe = Recipe.find(params[:id])
    material = Material.find(params[:id])
    recipe.destroy
    material.destroy
    redirect_to recipe_path
  end

  def update
  end
end
