class FavoritesController < ApplicationController
  before_action :require_user_logged_in, only: [:create, :destroy]
  
  def index
    @favs = current_user.favs.page(params[:page])
    @user = current_user
  end
  
  def create
    post = Idea.find(params[:idea_id])
    current_user.favorite(post)
    flash[:success] = 'favoriteにしました'
    redirect_to :back
  end

  def destroy
    post = Idea.find(params[:idea_id])
    current_user.unfavorite(post)
    flash[:success] = 'favoriteを解除しました'
    redirect_to :back
  end
end