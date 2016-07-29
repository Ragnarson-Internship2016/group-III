class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to :back, notice: 'Comment added.'
    else
      redirect_to :back, alert: 'Something went wrong. Try later.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :commentable_id, :commentable_type)
  end
end
