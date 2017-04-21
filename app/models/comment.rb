class Comment < ApplicationRecord
  belongs_to :idea
  belongs_to :user
  
  validates :idea_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  
  def self.ranking
    self.group(:idea_id).order('count_idea_id DESC').limit(10).count(:idea_id)
  end
end
