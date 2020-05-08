class ItemsController < ApplicationController

  require 'payjp'
  before_action :move_to_session, only: [:buycheck, :payment, :new]

  def index
    @items = Item.includes(:images, :category, :seller).order(created_at: :desc) 
    @parents = Category.all.order("id ASC").limit(13)
  end

  def category
    @categories = Category.where(ancestry: nil)
    respond_to do |format|
      format.json
    end
  end
  
  def new
    @item = Item.new
    @item.images.build
      @category_parent_array = Category.where(ancestry: nil).pluck(:name)
      @category_parent_array.unshift("選択してください")
  end
  
  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create
      @item = Item.new(item_params)
      @category_parent_array = Category.where(ancestry: nil).pluck(:name)
      if @item.save
        redirect_to root_path
      else
        render :new
      end
  end

  
  def show
    @item = Item.find(params[:id])
    @items = Item.includes(:images)
    @user = User.find(@item.seller_id)
  end

  def destroy
    @item = Item.find_by(id: params[:id])
    @item.destroy
    redirect_to root_path
  end

  def buycheck
    @item = Item.find(params[:item_id])
    @items = Item.includes(:images)
    set_address
    @cards = Card.where(user_id: current_user.id).count
    if @cards == 0
      render 'items/buycheck'
    else
      if @cards == 2
        card_sec = Card.where(user_id: current_user.id).last
        Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
        customer = Payjp::Customer.retrieve(card_sec.customer_id)
        @second_card_information = customer.cards.retrieve(card_sec.card_id)
      end
      card = Card.where(user_id: current_user.id).first
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
      render 'items/buycheck'
    end
  end

  def payment
    if params[:paycheck].blank? || params[:shipping_method].blank?
      redirect_to item_buycheck_path and return
    end
    item = Item.find(params[:item_id])
    card = set_payment_card
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    charge = Payjp::Charge.create(amount: item.price, card: card.card_id, currency: 'jpy', customer: card.customer_id)
    item[:buyer_id] = current_user.id
    if item.save
      redirect_to root_path
    else
      redirect_to item_buycheck_path
    end
  rescue Payjp::CardError
    flash[:alert] = "※※※このカードは使用できません。別のカードを使用して下さい※※※"
    redirect_to item_buycheck_path
  end


  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :condition, :delivery_charge, :delivery_day, :size, :prefecture_id, :category_id, :brand_id, images_attributes: [:image, :image_cache]).merge(seller_id: current_user.id, state: true)
  end

  def move_to_session
    redirect_to new_user_session_path unless user_signed_in?
  end

  def set_address
    @address = Address.find_by(user_id: current_user.id)
    @prefecture = Prefecture.find(@address.prefecture_id)
  end

  def set_payment_card
    if params[:shipping_method] == "card2"
      card = Card.where(user_id: current_user.id).second
    else
      card = Card.where(user_id: current_user.id).first
    end
  end
end
