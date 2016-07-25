class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      redirect_to root_url
    else
      render { action 'edit' }
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :surname, :city)
  end
end
