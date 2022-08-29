class FoodsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    @foods = current_user.foods
  end

  def show
    @food = Food.find(params[:id])
  end

  def create
    @food = current_user.foods.new(food_params)
    if @food.save
      redirect_to @food
    else
      render :new
    end
  end

  def new
    @food = Food.new
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    flash[:notice] = 'Food deleted successfully'
    redirect_to request.path
  end

  private

  def food_params
    params.require(:food).permit(:name, :price, :measurement_unit)
  end
end
