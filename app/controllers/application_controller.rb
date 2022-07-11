class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

def set_current_user
  @current_user = User.find_by(id: session[:user_id])
end

  def after_sign_in_path_for(resource)
    case resource
    when User
      root_path
    when Admin
      admin_users_path
    end
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトしました"
    case resource
    when :user
      new_user_session_path
    when :admin
      new_admin_session_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :name, :name_kana, :name_pass, :is_active])
  end
end