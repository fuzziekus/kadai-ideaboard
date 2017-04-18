class ToppagesController < ApplicationController
  def index
    @idea = Idea.new
    if logged_in?
      @user  = current_user
      @idea  = current_user.ideas.build  # form_for 用
    end

    @ideas = @search_ideas.order('created_at DESC').page(params[:page])
    # Idea.order('created_at DESC').page(params[:page])

  end
end
