class PostsController < ApplicationController
  before_action :set_post, only: [:show,:edit,:update]
  
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new

  end

  def new
    @post = Post.new
  end

  def create
    binding.pry
    @post = Post.new(post_params)
    @post.creator = User.last #pte of usermodel integration

    if @post.save
      flash[:notice] = "Your post was created"
      redirect_to posts_path
    else
      render :new
    end
    binding.pry

  end

  def edit
  end

  def update
    binding.pry
    if @post.update(post_params)
      flash[:notice] = "your post was updated"
      redirect_to post_path

    else
      render :edit
    end

  end

  private

  def post_params
    params.require(:post).permit(:title,:url,:description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
