class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user  = current_user
      @idea  = current_user.ideas.build  # form_for 用
    end
    @ideas = Idea.order('created_at DESC').page(params[:page])
  end
end
