class Public::RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
    @recipe.materials.new
    @recipe.recipe_descriptions.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer_id = current_customer.id
    if @recipe.save!
      redirect_to recipe_path(@recipe)
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
    if params[:q]
      @word = params[:q][:dish_name_cont]
    end
    @recipes = Recipe.all.page(params[:page])
    @search = Recipe.ransack(params[:q])
    @search_recipes = @search.result
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    redirect_to recipe_path(@recipe)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
  
  def my_recipes
    @recipes = current_customer.recipes
  end

   private

  def recipe_params
    params.require(:recipe).permit(:dish_name, :recipe_description, :number_people, :dish_image, :categoriy_id, :customer_id,
    materials_attributes: [:id, :material_name, :quantity, :_destroy],
    recipe_descriptions_attributes: [:id, :description, :procedure_image, :_destroy],
    tag_ids: [])
  end

end