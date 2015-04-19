class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find_by(slug: params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Comment created"
      redirect_to post_path(@post)
    else
      render "posts/show"
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    vote = Vote.create(user: current_user, vote: params[:vote], voteable: @comment)
    respond_to do |format|
      format.html {if vote.valid?; flash[:notice] = "Thanks for voting"; else; flash[:notice] = "You can only vote once"; end; redirect_to :back}
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end