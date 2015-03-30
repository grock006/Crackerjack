class Api::UsersController < ApplicationController

  def show
    render json: (current_user ? current_user : nil), 
      except: :password_digest
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      render json: user, except: [:password_digest]
    else
      render json: {errors: user.errors}
    end
  end

private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end


