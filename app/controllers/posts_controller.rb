class PostsController < ApplicationController
  before_action :set_post, only: [:show,:edit,:update,:vote]
  before_action :require_user, except: [:index, :show]
  
  def index
    @posts = Post.includes(:comments,:creator)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new

  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = "Your post was created"
      redirect_to posts_path
    else
      render :new
    end

  end

  def edit
  end

  def update

    if @post.update(post_params)
      flash[:notice] = "your post was updated"
      redirect_to post_path
    else
      render :edit
    end

  end

  def vote
    vote = Vote.create(user: current_user, vote: params[:vote], voteable: @post)

    if vote.valid?
      flash[:notice] = "Thank you for voting"
    else
      flash[:error] = "Can only vote once"
    end

    redirect_to :back
  end

  private

  def post_params
    params.require(:post).permit(:title,:url,:description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
