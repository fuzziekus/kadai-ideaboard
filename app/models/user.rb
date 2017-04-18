class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :ideas
  has_many :favorites
  has_many :favs, through: :favorites, source: :idea
  
  def favorite(other_idea)
    self.favorites.find_or_create_by(idea_id: other_idea.id)
  end
  
  def unfavorite(other_idea)
    fav = self.favorites.find_by(idea_id: other_idea.id)
    fav.destroy if fav
  end
  
  def beingfavorite?(other_idea)
    self.favs.include?(other_idea)
  end
end