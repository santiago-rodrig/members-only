class ApplicationController < ActionController::Base
  before_action :require_login

  def sign_in(user)
    session[:user_id] = user.id
    cookies.permanent[:remember_token] = user.renew_token
    self.current_user = user
    redirect_to root_url
  end

  def current_user
    return @current_user if @current_user
    return self.current_user = User.find_by(
      remember_token: Digest::SHA1.hexdigest(cookies[:remember_token])
    ) if cookies[:remember_token]
  end

  def current_user=(user)
    @current_user = user
  end

  def sign_out
    session.delete(:user_id)
    cookies.delete(:remember_token)
    self.current_user = nil
    redirect_to root_url
  end

  private

  def require_login
    unless current_user
      redirect_to login_url
    end
  end
end
