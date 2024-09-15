class CommentsController < ApplicationController
  def create
    @forum = Forum.find(params[:forum_id])
    @comment = @forum.comments.create(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to forum_path(@forum)
    else
      render "new"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:message)
  end
end
