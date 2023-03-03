class Public::RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
    @recipe.materials.new
  end

  def create
    @recire = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipe_path
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    material = Material.find(params[:id])
    recipe.destroy
    material.destroy
    redirect_to recipe_path
  end

  def index
  end

  def edit
  end

  def show
  end

   private

  def recipe_params
    params.require(:recipe).permit(:dish_name, :recipe_description, :number_people, :procedure, :didh_image, :procedure_image, :categoriy_id, :tag_id, :customer_id,
    material_attributes:[:material_name, :quantity, :_destroy])
  end

end
