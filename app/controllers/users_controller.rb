class UsersController < ApplicationController
  # Devise authentication is to be turned on once the front-end is ready.
  # before_action :authenticate_user!

  def index
    @users = User.all

    render json: @users
  end

  def show
    render json: user
  end

  def update
    if user.update(user_params)
      render json: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    user.destroy
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def user_params
    # params.fetch(:user, {})
    params.require(:user).permit(:email)
  end
end
