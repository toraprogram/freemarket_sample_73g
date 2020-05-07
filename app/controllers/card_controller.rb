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
    cards = Card.where(user_id: current_user.id).count
    card = Card.where(user_id: current_user.id).first
    if cards.blank?
      redirect_to action: :index
    end
    if cards == 2
      card_sec = Card.where(user_id: current_user.id).last
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card_sec.customer_id)
      @second_card_information = customer.cards.retrieve(card_sec.card_id)
    end
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
  end

end
