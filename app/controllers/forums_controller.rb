class ForumsController < ApplicationController
  def index
    @forums = Forum.all.order("created_at DESC")
  end

  def new
    @forum = Forum.new
  end

  def create
    @forum = Forum.new(forum_params)
    if @forum.save
      redirect_to root_path
    else
      render "new"
    end
  end

  private
    def forum_params
      params.require(:forum).permit(:thread, :content)
    end
end
