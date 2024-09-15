class CommentsController < ApplicationController
before_action :find_forum
before_action :find_comment, only [:edit, :update, :destroy]

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

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to forum_path(@forum)
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to forum_path(@forum)
  end

  private
  def comment_params
    params.require(:comment).permit(:message)
  end

  def find_forum
    @forum = Forum.find(params[:forum_id])
  end

  def find_comment
    @comment = @forum.comments.find(params[:id])
  end
end
