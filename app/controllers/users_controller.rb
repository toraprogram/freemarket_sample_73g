class UsersController < ApplicationController
  def index
  end

  def show
    render "users/#{params[:name]}", locals: {user: current_user}
  end

  def edit
    render "users/#{params[:name]}", locals: {user: current_user}
  end

  def new
  end
end

