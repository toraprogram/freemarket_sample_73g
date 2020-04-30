class ItemsController < ApplicationController
  def index
  end
  
  def new
    @item = Item.new
    @item.images.build
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path notice: '商品を出品しました'
    else
      render :new
    end
    
  end
  
  def show
  end




  private

  def item_params
    params.require(:item).permit(:name, :description, :condition, :delivery_charge, :delivery_day, :size, :category_id, :brand_id, :price, :prefecture_id, images_attributes: [:image]).merge(seller_id: 1, state: true)
    # .merge(seller_id: current_user.id)ユーザーデータできたら修正する
  end

end
