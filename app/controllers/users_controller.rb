class UsersController < ApplicationController
  def index; end

  def show
    redirect_to foods_path
  end
end
