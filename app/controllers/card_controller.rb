class CardController < ApplicationController
  require 'payjp'

  def index
    card = Card.where(user_id: current_user.id)
    redirect_to action: :show if card.exists?
  end

  def new
  end

  def pay
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: :new
    else
      customer = Payjp::Customer.create(
        email: current_user.email,
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to controller: :card, action: :show
      else
        redirect_to action: "pay"
      end
    end
  end

  def destroy
    card = Card.find_by(card_id: params[:id])
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    customer = Payjp::Customer.retrieve(card.customer_id)
    customer.delete
    card.destroy
    redirect_to action: :index
  end

  def show
    redirect_to action: :index unless current_user.cards.present?
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    customer = Payjp::Customer.retrieve(current_user.cards.first.customer_id)
    @default_card_information = customer.cards.retrieve(current_user.cards.first.card_id)
    customer2 = Payjp::Customer.retrieve(current_user.cards.last.customer_id) if current_user.cards.count == 2
    @second_card_information = customer2.cards.retrieve(current_user.cards.last.card_id) if current_user.cards.count == 2
  end

end
