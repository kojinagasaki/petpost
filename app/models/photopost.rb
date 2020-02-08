class Photopost < ApplicationRecord
  belongs_to :user
  validates :content, length: { maximum: 200 }
  validates :title, presence: true, length: { maximum: 50 }
  validates :img, presence: true
  
  has_many :users, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :liked, through: :favorites, source: :user, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  mount_uploader :img, ImgUploader
  
   enum category:{
    dog: 0,
    cat: 1,
    other: 2
  }
end

