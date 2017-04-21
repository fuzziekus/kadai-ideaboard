class IdeasController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:update, :destroy, :edit, :commented]
  
  def show
    @flag = false
    if current_user.ideas.find_by(id: params[:id])
      @flag = true
    end
    @idea = Idea.find_by(id: params[:id])
    @comments = @idea.comments
    @comment  = Idea.find_by(id: params[:id]).comments.new
    @comment.user_id = current_user.id
    @comment.idea_id = @idea.id
  end
  
  def edit
  end
  
  def update
    if @idea.update(idea_params)
      flash[:success] = 'idea は正常に更新されました'
      redirect_to @idea
    else
      flash.now[:danger] = 'idea は更新されませんでした'
      render :edit
    end
  end
  
  def create
    @idea = current_user.ideas.build(idea_params)
    if @idea.save
      flash[:success] = '素敵なアイデアをありがとう！'
      redirect_to root_url
    else
      @ideas = Idea.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'アイデアの投稿に失敗しました。アイデアの文字数は1～255文字で入力してください。画像のみの投稿はできません。'
      render 'toppages/index'
    end
  end

  def destroy
    @idea.destroy
    flash[:success] = 'アイデアを削除しました。'
    redirect_to root_path
  end

  private

  def idea_params
    params.require(:idea).permit(:content, :image)
  end
  
  def correct_user
    @idea = current_user.ideas.find_by(id: params[:id])
    unless @idea
      redirect_to root_path
    end
  end
end
