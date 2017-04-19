class IdeasController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:update, :destroy, :edit]
  
  def show
    @flag = false
    if current_user.ideas.find_by(id: params[:id])
      @flag = true
    end
    @idea = Idea.find_by(id: params[:id])
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
      @ideas = current_user.ideas.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
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
    params.require(:idea).permit(:content)
  end
  
  def correct_user
    @idea = current_user.ideas.find_by(id: params[:id])
    unless @idea
      redirect_to root_path
    end
  end
end
