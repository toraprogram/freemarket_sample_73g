class UsersController < ApplicationController
  before_action :signin_check

  def index
    @user = User.find(current_user[:id])
    @boughtitems = @user.items.last(2)
    @imagelast = Image.find_by(item_id: @boughtitems.last.id) if @user.items.present?
    @imagefirst = Image.find_by(item_id: @boughtitems.first.id) if @user.items.count > 1
  end

  def show
    sellitems = Item.where(seller_id: current_user[:id])
    @sellingitems = sellitems.select { |sellitem| sellitem.buyer_id == nil }
    @solditems = sellitems.select { |sellitem| sellitem.buyer_id != nil }
    @boughtitems = Item.where(buyer_id: current_user[:id])
    render "users/#{params[:name]}", locals: {user: current_user}
  end

  def edit
    @user = User.find(current_user.id)
    render "users/#{params[:name]}", locals: {user: current_user}
  end

  def update
    if current_user.update(user_params)
      redirect_to :index
    else
      render :edit
    end
  end


  private

  def signin_check
    redirect_to new_user_session_path unless user_signed_in?
  end
end

