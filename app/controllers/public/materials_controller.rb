class Public::MaterialsController < ApplicationController
   private
  def material_params
      params.require(:material).permit(:material_name, :recipe_id, :customer_id)
end
end
