class FoodsController < ApplicationController
  def index
    @foods = Food.where(user_id: current_user.id).includes(:recipe_foods)

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @foods }
      format.json { render json: @foods }
    end
  end

  def show
    @food = Food.where(user_id: current_user.id).find(params[:id])
  end

  def new
    @food = Food.new
    respond_to do |format|
      format.html { render :new, locals: { food: @food } }
    end
  end

  def create
    # new object from params
    @food = Food.new(post_params)

    # respond_to block
    respond_to do |format|
      format.html do
        if @food.save
          # success message
          flash[:success] = 'Food created successfully'
          # redirect to index
          redirect_to foods_url
        else
          flash.now[:error] = 'Error: Food could not be created'
          # render new
          render :new, locals: { food: @food }
        end
      end
    end
  end

  def destroy
    Food.find(params[:id]).delete
  end

  private

  def post_params
    post_params = params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
    post_params[:user_id] = current_user.id
    post_params
  end
end
