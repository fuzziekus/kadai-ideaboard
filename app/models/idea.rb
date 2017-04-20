class Idea < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  
  mount_uploader :image, ImageUploader
  
  has_many :favorites
  has_many :users, through: :favorites
  has_many :comments
  has_many :comment_users, through: :comments
  
end
