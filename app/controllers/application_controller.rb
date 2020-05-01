class ApplicationController < ActionController::Base

  before_action :basic_auth, if: :production?
  
  #<他の人に影響が出る可能性を考慮し、コメントアウトしてます。中野>
  # 下の表記を有効にするとlocalhost:3000でsign_inの画面に飛んでしまうため無効化中
  # before_action :authenticate_user!
  # before_action :configure_permitted_parameters, if: :devise_controller?

  # protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:family_name,:first_name,:family_name_kana,:first_name_kana,:phone_authy,:birthday])
  # end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
      password == Rails.application.credentials[:basic_auth][:pass]
    end
  end

  def production?
    Rails.env.production?
  end
  
end
