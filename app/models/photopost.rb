class Photopost < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 200 }
  # validates :title, presence: true, length: { maximum: 50 }
  # validates :img, presence: true
  
   enum category:{
    dog: 0,
    cat: 1, 
    other: 2, 
  }
end
