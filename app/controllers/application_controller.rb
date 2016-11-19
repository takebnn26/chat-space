class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  class PermissionDenied < StandardError; end

  rescue_from PermissionDenied do
    redirect_to :root, alert: "ユーザーであるか確認してください。"
  end

  private

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def comfirm_user(resource)
    raise PermissionDenied if resource != current_user
  end

end
