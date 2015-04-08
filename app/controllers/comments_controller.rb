class CommentsController < ApplicationController
  def create
    binding.pry
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.creator = User.last

    if @comment.save
      flash[:notice] = "Comment created"
      redirect_to post_path(@post)
    else
      render "posts/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end