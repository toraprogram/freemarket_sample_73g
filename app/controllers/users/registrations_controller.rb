# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new(sign_up_params)
    @address = @user.build_address(address_params)
  end

  def create
    @user = User.new(sign_up_params)
    @address = @user.build_address(address_params)
    form_error_check(@user)
    @user.save
    sign_in(:user,@user)
  end

  def new_address
  end
  
  def create_address
    @user = User.new
    @address = Address.new(address_params)
    @user.build_address(@address.attributes)
    @user.save
    sign_in(:user,@user)
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:family_name,:first_name,:family_name_kana,:first_name_kana,:phone_authy,:birthday])
  end

  def address_params
    params.require(:address).permit(:postal_code,:prefecture_id,:city,:block)
  end
end
