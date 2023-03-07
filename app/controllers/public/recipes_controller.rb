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
    recipe.destroy
    redirect_to my_recipes_recipes_path
  end

  def index
     @categories = Categoriy.all
    if params[:q]
      @word = params[:q][:dish_name_cont]
      @search = Recipe.ransack(params[:q])
      @recipes = @search.result.page(params[:page])
    else
    # @recipes = params[:tag_id].present? ? Tag.find(params[:tag_id]).recipes.page(params[:page]) : Recipe.all.page(params[:page])

      if params[:categoriy_id] == nil
        @recipes = Recipe.all.page(params[:page])
      else
        @recipes = Recipe.where(categoriy_id:params[:categoriy_id]).page(params[:page])

      end
    end

    #   @recipes = Item.where(genre_id: params[:genre_id])
    #   # @name = Genre.find(params[:genre_id]).name
    #   @categories = Categoriy.all
    #   render :index
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
    @customer = Customer.find(@recipe.customer.id)
    @comment = Comment.new
    # @recipes = current_customer.recipes.all
  end

  def my_recipes
    @recipes = current_customer.recipes.page(params[:page])
  end

   private
  def recipe_params
    params.require(:recipe).permit(:dish_name, :recipe_description, :number_people, :dish_image, :categoriy_id, :customer_id,
    materials_attributes: [:id, :material_name, :quantity, :_destroy],
    recipe_descriptions_attributes: [:id, :description, :procedure_image, :_destroy],
    tag_ids: [])
  end
end
