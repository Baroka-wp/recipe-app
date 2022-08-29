class RecipesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, except: [:public]

  def index
    @recipes = current_user.recipes.includes(:user)
  end

  def show
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:notice] = "Recipe deleted successfully"
    redirect_to recipes_path
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def new
    @recipe = Recipe.new
  end

  def public
    @recipes = Recipe.all.order(created_at: :desc).includes(:user)
  end

  private
  def recipe_params
    params.require(:recipe).permit(:name, :description, :prep_time, :cooking_time)
  end
end
