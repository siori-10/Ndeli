class Public::RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
    @recipe.materials.new
    @recipe.recipe_descriptions.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer_id = current_customer.id
    if params[:post]
      if @recipe.save(context: :publicize)
      redirect_to recipe_path(@recipe), notice: "レシピを投稿しました！"
      else
        flash[:alert] = "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
        render :new
      end
    else
      if @recipe.update(is_draft: true)
        redirect_to recipes_draft_path(current_customer), notice: "レシピを下書き保存しました！"
      else
         flash[:alert] = "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
        render :new
      end
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
      if params[:categoriy_id] == nil
        @recipes = Recipe.where(is_draft:false).page(params[:page])
      else
        @recipes = Recipe.where(categoriy_id:params[:categoriy_id]).page(params[:page])
      end
    end
  end


  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if params[:publicize_draft]
      @recipe.attributes = recipe_params.merge(is_draft: false)
      # @recipe.is_draft = false

      if @recipe.save(context: :publicize)

        if (@recipe.materials.size > 0) && (@recipe.recipe_descriptions.size > 0)
           redirect_to recipe_path(@recipe.id), notice: "下書きのレシピを公開しました！"
        else
          @recipe.update(is_draft: false)
          flash[:alert] = "レシピを公開できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
          render :edit
        end
      else
          @recipe.is_draft = true
          render :edit, alert: "レシピを公開できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    elsif params[:update_post]
      @recipe.attributes = recipe_params

      if @recipe.save(context: :publicize)
        if (@recipe.materials.size > 0) && (@recipe.recipe_descriptions.size > 0)
          redirect_to recipe_path(@recipe.id), notice: "レシピを更新しました！"
        else
          @recipe.update(is_draft: false)
          flash[:alert] = "レシピを公開できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
          render :edit
        end
      end

    else

      if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: "下書きレシピを更新しました！"
      end
    end
  end

  def draft
     @recipes = current_customer.recipes.where(is_draft: true).page(params[:page])
  end

  def show
    @recipe = Recipe.find(params[:id])
    @customer = Customer.find(@recipe.customer.id)
    @comment = Comment.new
    # @recipes = current_customer.recipes.all
  end

  def my_recipes
    @recipes = current_customer.recipes.where(is_draft: false).page(params[:page]).per(10)
  end

  private
  def recipe_params
    params.require(:recipe).permit(:dish_name, :recipe_description, :number_people, :dish_image, :categoriy_id, :customer_id , :material_name,
    materials_attributes: [:id, :material_name, :quantity, :_destroy],
    recipe_descriptions_attributes: [:id, :description, :procedure_image, :_destroy])
  end
end
