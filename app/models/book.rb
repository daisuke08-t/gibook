class Book < ApplicationRecord
  validates :user_id, presence: true
  validates :title, presence: true
  
  
  belongs_to :user
end
