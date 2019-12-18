class ApplicationController < ActionController::Base
  def sig_in(user)
    session[:user_id] = user.id
    cookies.permanent[:remember_token] = user.renew_token
    self.current_user = user
  end

  def current_user
    @current_user || self.current_user =  User.find_by(
      remember_token: cookies[:remember_token])
  end

  def current_user=(user)
    @current_user = user
  end
end
