class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def index
    redirect_to new_user_url
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'User has been created'
      sign_in(@user)
    else
      render action: 'new'
    end
  end

  def change_password
    @user = User.find(params[:id])
  end

  def update_password
    @user = User.find(params[:id])
    current = password_params.fetch(:current_password)
    pass_new = password_params[:password]
    pass_confirm = password_params[:password_confirmation]

    if BCrypt::Password.new(@user.password_digest).is_password?(current)
      if @user.update(password: pass_new, password_confirmation: pass_confirm)
        flash[:success] = 'Password Updated'
        redirect_to @user
      else
        render :change_password
      end
    else
      @user.valid?
      @user.errors.add(:base, :current_password_not_equal,
                       message: 'Current password is not the same')
      render :change_password
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])

    if user.update(user_params)
      flash[:success] = 'User updated'
      redirect_to user
    else
      render action: 'edit'
    end
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
    )
  end

  def password_params
    params.require(:user).permit(
      :current_password,
      :password,
      :password_confirmation
    )
  end
end
