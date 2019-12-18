class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: safe_params[:email])
    if user.authenticate(safe_params[:password])
      sign_in(user)
    else
      # TODO
    end
  end

  def destroy
  end

  private

  def safe_params
    params.require(:session).permit(:email, :password)
  end
end
