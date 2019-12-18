class ApplicationController < ActionController::Base
  def sign_in(user)
    session[:user_id] = user.id
    cookies.permanent[:remember_token] = user.renew_token
    self.current_user = user
    redirect_to posts_url
  end

  def current_user
    @current_user || self.current_user =  User.find_by(
      remember_token: cookies[:remember_token])
  end

  def current_user=(user)
    @current_user = user
  end

  def sign_out
    session.delete(:user_id)
    cookies.delete(:remember_token)
    self.current_user = nil
    redirect_to posts_url
  end

  private

  def require_login
    flash[:danger] = 'You are not a member'
    redirect_to posts_url
  end
end
