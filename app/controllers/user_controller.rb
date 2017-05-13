class UserController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def update
    if current_user.update_attribures(user_params)
      render :show
    else
      render json: { errors: current_user_errors }, status: :unprocessbel_entity
    end
  end

  private

  def user_params
    parms.request(':user').permit(:username, :emial, :password, :bio, :image)
  end
end
