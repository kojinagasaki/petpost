class Photopost < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 200 }
  # validates :title, presence: true, length: { maximum: 50 }
  # validates :img, presence: true
  
  has_many :users
  has_many :liked, through: :favorites, source: :user
  
   enum category:{
    dog: 0,
    cat: 1, 
    other: 2, 
  }
end
