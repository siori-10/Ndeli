class ApplicationController < ActionController::Base
 before_action :set_search
 
# 検索機能をつくるためのransackの関数
def set_search
  @search = Recipe.ransack(params[:q])
  @search_recipes = @search.result
end

end