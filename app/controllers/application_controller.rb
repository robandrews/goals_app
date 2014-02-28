class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :signed_in?, :current_user, :sign_in!, :sign_out, :ensure_signed_in

  def signed_in?
    !!current_user
  end

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def sign_in!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def sign_out
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def ensure_signed_in
    redirect_to new_session_url if !signed_in?
  end
end
