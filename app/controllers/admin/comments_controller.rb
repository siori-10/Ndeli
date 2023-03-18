class Admin::CommentsController < ApplicationController
  def index
  end

  def destroy
    comment = Comment.find(params[:id])
    recipe = comment.recipe
    comment.destroy
    redirect_to admin_recipe_path(recipe)
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :recipe_id)
  end
end
