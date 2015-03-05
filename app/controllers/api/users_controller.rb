module Api
class UsersController < ApplicationController

  def new
    user = User.new
  end

  def create
    user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))

    if user.save # sign up was success
      render json: user.to_json
    else
      render json: {user: user, user: review.errors.full_messages}, status: 422
    end
  end

end
end

