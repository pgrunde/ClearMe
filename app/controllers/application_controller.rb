class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_filter :ensure_authed_inhouse_user

  def ensure_authed_inhouse_user
    redirect_to root_path unless current_inhouse_user
  end

  def ensure_authed_external_user
    redirect_to root_path unless current_external_user
  end

  def current_inhouse_user
    if session[:inhouse_user_id]
      InhouseUser.find(session[:inhouse_user_id])
    else
      false
    end

  end
  def current_external_user
    ExternalUser.find(session[:external_user_id])
  end
end
