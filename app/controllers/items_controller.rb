class ItemsController < ApplicationController
  def index
  end
  
  def new
    @item = Item.new
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
    params.require(:item).permit(:name, :price, :description, :condition, :delivery_charge, :delivery_day, :size, :region, :category_id, :brand_id).merge(seller_id: 1, state: true)
    # .merge(seller_id: current_user.id)ユーザーデータできたら修正する
  end

end
