class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_search

  include SessionsHelper
  
  def routing_error
    raise ActionController::RoutingError, params[:path]
  end

  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end

  def counts(user)
    @count_ideas = user.ideas.count
  end
  
  def set_search
    @search = Idea.ransack(params[:q])
    @search_ideas = @search.result #.page(params[:page])
  end

end