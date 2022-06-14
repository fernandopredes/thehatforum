class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @posts = Post.all.order('created_at DESC')
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
      if @post.save
        redirect_to @post
      else
        render 'new'
      end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def frontend
    @posts = Post.where(category: 'Front-End')
  end

  def backend
    @posts = Post.where(category: 'Back-End')
  end

  def gamedev
    @posts = Post.where(category: 'GameDev')
  end

  def datascience
    @posts = Post.where(category: 'Data Science')
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :category)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
