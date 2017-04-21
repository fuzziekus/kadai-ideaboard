class CommentsController < ApplicationController
  before_action :require_user_logged_in

  def index
    comments = Comment.order('created_at DESC').where(user_id: current_user)
    @ideas = []
    comments.each{|comment|
      @ideas.push Idea.order('created_at DESC').find_by(id: comment.idea_id)
    }
    p @ideas.first
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = 'コメントを投稿しました。'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'コメントの投稿に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end


  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    flash[:success] = 'コメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :idea_id)
  end
end
