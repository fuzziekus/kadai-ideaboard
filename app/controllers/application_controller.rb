class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_search

  include SessionsHelper
  
  unless Rails.env.development?
    rescue_from Exception,                        with: :_render_500
    rescue_from ActiveRecord::RecordNotFound,     with: :_render_404
    rescue_from ActionController::RoutingError,   with: :_render_404
  end
  
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
  
  def _render_404(e = nil)
    logger.info "Rendering 404 with exception: #{e.message}" if e
    if request.format.to_sym == :json
      render json: { error: '404 error' }, status: :not_found
    else
      render file: '/404.html', status: 404, layout: false, content_type: 'text/html'
    end
  end
  def _render_500(e = nil)
    logger.error "Rendering 500 with exception: #{e.message}" if e
    if request.format.to_sym == :json
      render json: { error: '500 error' }, status: :internal_server_error
    else
      render file: '/500.html', status: 500, layout: false, content_type: 'text/html'
    end
  end
end