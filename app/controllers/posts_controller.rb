class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :frontend]
  def index
    # @posts = Post.all.order('created_at DESC')
    @posts = policy_scope(Post).order(created_at: :desc)
    if params[:category]
      case params[:category]
      when "frontend"
        @posts = @posts.where(category: 'Front-End').order('created_at DESC')
      when "backend"
        @posts = @posts.where(category: 'Back-End').order('created_at DESC')
      when "gamedev"
        @posts = @posts.where(category: 'GameDev').order('created_at DESC')
      when "datascience"
        @posts = @posts.where(category: 'Data Science').order('created_at DESC')
      end
    end
  end

  def new

    @post = current_user.posts.build
    authorize @post
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
    authorize @post
  end

  def show
    authorize @post
    @post = Post.find(params[:id])
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end

  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to root_path
  end

  def frontend
    # @posts = Post.where(category: 'Front-End').order('created_at DESC')

    @posts = policy_scope(Post).where(category: 'Front-End').order(created_at: :desc)
  end

  def backend
    @posts = Post.where(category: 'Back-End').order('created_at DESC')
  end

  def gamedev
    @posts = Post.where(category: 'GameDev').order('created_at DESC')
  end

  def datascience
    @posts = Post.where(category: 'Data Science').order('created_at DESC')
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :category)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
