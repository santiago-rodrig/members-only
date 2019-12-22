class PostsController < ApplicationController
  skip_before_action :require_login, except: [:new, :create]

  def new
    @post = Post.new
  end

  def renew
    redirect_to new_post_url
  end

  def create
    @post = Post.new({ user_id: current_user.id }.merge(safe_params))

    if @post.save
      flash[:success] = 'You post has been created'
      redirect_to root_url
    else
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  private

  def safe_params
    params.require(:post).permit(:title, :body)
  end
end
