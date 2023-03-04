class Public::RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
    @recipe.materials.new
    @recipes = Recipe.all
  end

  def create
    @recire = Recipe.new(recipe_params)
    @recire.customer_id = current_customer.id
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
    @recipes = Recipe.all
  end

  def edit
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

   private

  def recipe_params
    params.require(:recipe).permit(:dish_name, :recipe_description, :number_people, :procedure, :didh_image, :procedure_image, :categoriy_id, :customer_id,
    material_attributes:[:material_name, :quantity, :_destroy], tag_ids: [])
  end

end