class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'Your user has been created'
      sign_in(@user)
    else
      flash[:danger] = 'Your input is wrong'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  def show
    @user = User.find(params[:id])
  end

  def posts
    @posts = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
