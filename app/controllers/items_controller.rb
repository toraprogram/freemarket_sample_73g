class ItemsController < ApplicationController
  
  
  before_action :set_find,only:[:show, :destroy]
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
    @items = Item.includes(:images)
    @user = User.find(@item.seller_id)
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def buycheck
    render 'items/buycheck'
  end


  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :condition, :delivery_charge, :delivery_day, :size, :prefecture_id, :category_id, :brand_id, images_attributes: [:image, :image_cache]).merge(seller_id: current_user.id, state: true)
  end

  def set_find
    @item = Item.find(params[:id])
  end
end
