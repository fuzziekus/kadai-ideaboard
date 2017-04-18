class RankingsController < ApplicationController
  def fav
    @ranking_counts = Favorite.ranking
    @ideas = Idea.find(@ranking_counts.keys)
  end
end
