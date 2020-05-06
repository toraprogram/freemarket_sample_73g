class UsersController < ApplicationController
  before_action :signin_check

  def index
    @user = User.find(current_user[:id])
  end

  def show
    render "users/#{params[:name]}", locals: {user: current_user}
  end

  def edit
    render "users/#{params[:name]}", locals: {user: current_user}
  end


  private

  def signin_check
    redirect_to new_user_session_path unless user_signed_in?
  end
end

