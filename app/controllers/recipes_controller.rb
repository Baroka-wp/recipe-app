class RecipesController < ApplicationController
   def index
    @recipes = Recipe.where(user_id: current_user.id).includes(:recipe_foods)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @recipes }
      format.json { render :json => @recipes }
    end
  end

  def show
    @recipe = Recipe.where(user_id: current_user.id).find(params[:id]).includes(:recipe_foods)
  end

  def new
    @recipe = Recipe.new
    respond_to do |format|
      format.html { render :new, locals: { recipe: @recipe } }
    end
  end

  def create
    # new object from params
    @recipe = Recipe.new(post_params)

    # respond_to block
    respond_to do |format|
      format.html do
        if @recipe.save
          # success message
          flash[:success] = 'Recipe created successfully'
          # redirect to index
          redirect_to recipes_url
        else
          flash.now[:error] = 'Error: Recipe could not be created'
          # render new
          render :new, locals: { recipe: @recipe }
        end
      end
    end
  end

  def destroy
    Recipe.find(params[:id]).delete
  end

  private

  def post_params
    post_params = params.require(:recipe).permit(:name, :prep_time, :cooking_time, :description, :public)
    post_params[:user_id] = current_user.id
    post_params
  end
end
