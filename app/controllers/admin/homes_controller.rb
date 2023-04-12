class Admin::HomesController < ApplicationController
  def top
     @categories = Categoriy.all
    if params[:q]
      @word = params[:q][:dish_name_cont]
      @search = Recipe.ransack(params[:q])
      @recipes = @search.result.page(params[:page])
    else
      if params[:categoriy_id] == nil
        @recipes = Recipe.where(is_draft:false).page(params[:page])
      else
        @recipes = Recipe.where(categoriy_id:params[:categoriy_id]).page(params[:page])
      end
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(:dish_name, :recipe_description, :number_people, :dish_image, :categoriy_id, :customer_id,
    materials_attributes: [:id, :material_name, :quantity, :_destroy],
    recipe_descriptions_attributes: [:id, :description, :procedure_image, :_destroy])
  end
end