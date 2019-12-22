module SessionsHelper
  def logged_in?
    session[:user_id]
  end

  def is_premium?
    User.find(session[:user_id]).premium?
  end
end
