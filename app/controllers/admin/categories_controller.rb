class Admin::CategoriesController < ApplicationController
  def index
   @categoriy = Categoriy.new
   @categories = Categoriy.all
  end

  def create
    @categoriy = Categoriy.new(categoriy_params)
    @categoriy.save
    redirect_to admin_categories_path
  end
  
  def destroy
    categoriy = Categoriy.find(params[:id])
    categoriy.destroy
    redirect_to admin_categories_path
    
  end

  def edit
    @categoriy = Categoriy.find(params[:id])
  end

  def update
    categoriy = Categoriy.find(params[:id])
    categoriy.update(categoriy_params)
    redirect_to admin_categories_path
  end
  
  private
  def categoriy_params
    params.require(:categoriy).permit(:categoriy_name)
  end
end
