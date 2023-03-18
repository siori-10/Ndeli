class Admin::RecipesController < ApplicationController
  def index

  end

  def show
    @recipe = Recipe.find(params[:id])
    @customer = Customer.find(@recipe.customer.id)
  end

  def edit
     @recipe = Recipe.find(params[:id])
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to admin_root_path
  end

  def update
  end

   private
  def recipe_params
    params.require(:recipe).permit(:dish_name, :recipe_description, :number_people, :dish_image, :categoriy_id, :customer_id,
    materials_attributes: [:id, :material_name, :quantity, :_destroy],
    recipe_descriptions_attributes: [:id, :description, :procedure_image, :_destroy])
  end
end
