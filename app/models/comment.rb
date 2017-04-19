class Comment < ApplicationRecord
  belongs_to :idea
  belongs_to :user
  
  validates :idea_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
end
