# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_login

  def sign_in(user)
    session[:user_id] = user.id
    cookies.permanent[:remember_token] = user.renew_token
    self.current_user = user
    redirect_to user
  end

  def current_user
    return @current_user if @current_user

    return unless cookies[:remember_token]

    self.current_user = User.find_by(
      remember_token: Digest::SHA1.hexdigest(cookies[:remember_token])
    )
  end

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
