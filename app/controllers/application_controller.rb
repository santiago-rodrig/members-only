# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_login

  def sign_in(user)
    session[:user_id] = user.id
    cookies.permanent[:remember_token] = user.renew_token
    self.current_user = user
    redirect_to user
  end

# hope this is enough
def current_user
  return nil unless cookies[:remember_token]

  @current_user ||= User.find_by(
    remember_token: Digest::SHA1.hexdigest(cookies[:remember_token])
  )
end

# same as
# def current_user=(user)
#   @current_user = user
# end
attr_writer :current_user

  def sign_out
    session[:user_id] = nil
    cookies[:remember_token] = nil
    self.current_user = nil
    redirect_to root_url
  end

  private

  def require_login
    redirect_to login_url unless current_user
  end
end
