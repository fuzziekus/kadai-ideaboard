class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :idea
  
  validates :user_id, presence: true
  validates :idea_id, presence: true
  
  def self.ranking
    self.group(:idea_id).order('count_idea_id DESC').limit(10).count(:idea_id)
  end
end
