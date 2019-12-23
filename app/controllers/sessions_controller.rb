# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    user = User.find_by(email: safe_params[:email])
    if user&.authenticate(safe_params[:password])
      sign_in(user)
    else
      flash.now[:danger] = 'Wrong input'
      render :new
    end
  end

  def destroy
    sign_out
  end

  private

  def safe_params
    params.require(:session).permit(:email, :password)
  end
end
