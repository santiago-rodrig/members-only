# frozen_string_literal: true

module SessionsHelper
  def logged_in?
    controller.current_user
  end

  def premium?
    controller.current_user.premium?
  end
end
