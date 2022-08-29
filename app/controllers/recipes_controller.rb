class RecipesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, except: [:public]

  def index
    @recipes = current_user.recipes.includes(:recipe_foods, :user)
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
    @recipes = Recipe.includes(:recipe_foods, :foods, :user).where(public: true).order(created_at: :desc).map do |recipe|
      {
        id: recipe.id,
        name: recipe.name,
        description: recipe.description,
        author: recipe.user.name,
        created_at: recipe.created_at,
        items: recipe.recipe_foods_count,
        total_price: recipe.foods.map(&:price).sum,
      }
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(:name, :description, :prep_time, :cooking_time)
  end
end
