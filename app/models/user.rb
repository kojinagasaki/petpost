class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence:true, length: {maximum: 50 }
  validates :content, length: {maximum: 200 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :photoposts, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow, dependent: :destroy
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverses_of_relationship, source: :user, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :likings, through: :favorites, source: :photopost , dependent: :destroy
  has_many :comments, dependent: :destroy
  
  mount_uploader :icon, IconUploader
  mount_uploader :back_img, BackImgUploader
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_photoposts
    Photopost.where(user_id: self.following_ids + [self.id])
  end
  
  def feed__followings_photoposts
    Photopost.where(user_id: self.following_ids)
  end
  
  def like(photopost)
    unless self == photopost
      self.favorites.find_or_create_by(photopost_id: photopost.id)
    end
  end
  
  def unlike(photopost)
    favorite = self.favorites.find_by(photopost_id: photopost.id)
    favorite.destroy if favorite
  end
  
  def liking?(photopost)
    self.likings.include?(photopost)
  end
  
  def comment(photopost)
      self.comments.find_or_create_by(photopost_id: photopost.id)
  end
end
