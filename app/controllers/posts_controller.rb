class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new({ user_id: current_user.id }.merge(safe_params))

    if @post.save
      flash[:success] = 'You post has been created'
      redirect_to posts_url
    else
      render :new
    end
  end

  def index
    @user = current_user
    @posts = Post.all
  end

  private

  def safe_params
    params.require(:post).permit(:title, :content)
  end
end
