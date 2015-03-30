class Api::SessionsController < ApplicationController

  def create
    user = User.find_by(username: params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      render json: user, only: [:id, :username], status: 200  
    else
      render json: {error: "Username or password is incorrect"}
    end
  end

  def destroy
    session[:user_id] = nil
    render json: nil, status: 200
  end

end