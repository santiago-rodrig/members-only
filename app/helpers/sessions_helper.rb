# frozen_string_literal: true

module SessionsHelper
  def logged_in?
    session[:user_id]
  end

  def premium?
    User.find(session[:user_id]).premium?
  end
end
