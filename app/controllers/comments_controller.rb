class CommentsController < ApplicationController
  before_action :require_user_logged_in

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = 'コメントを投稿しました。'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = 'コメントの投稿に失敗しました。'
      redirect_back 
    end
  end


  def destroy
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :idea_id)
  end
end
