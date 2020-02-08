class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :photopost
  
  validates :comment, presence:true, length: {maximum: 100 }
end
