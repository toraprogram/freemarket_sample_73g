class ItemsController < ApplicationController

  def index
  end

  def category
    @categories = Category.where(ancestry: nil)
    respond_to do |format|
      format.json
    end
  end
  
  def new
    @item = Item.new
    @category_parent_array = Category.where(ancestry: nil)
  end

   def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(id: params[:parent_id], ancestry: nil).children
  end

  def get_category_grandchildren
    #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find(params[:child_id]).children
  end

  def create
      @item = Item.new(item_params)
      if @item.save
        redirect_to root_path
      else
        render :new
      end
  end
  
  def show
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :condition, :delivery_charge, :delivery_day, :size, :category_id, :category_parent_id, :brand_id, :prefecture_id).merge(seller_id: 1, state: true)
    # .merge(seller_id: current_user.id)ユーザーデータできたら修正する
  end

end
